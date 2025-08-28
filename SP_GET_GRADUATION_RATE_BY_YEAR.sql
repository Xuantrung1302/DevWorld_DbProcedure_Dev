USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec SP_GET_GRADUATION_RATE_BY_YEAR 2025

ALTER PROCEDURE [SP_GET_GRADUATION_RATE_BY_YEAR]
    @Year INT
AS
BEGIN

    ;WITH SubjectsPerCourse AS (
        SELECT S.course_id, COUNT(SUB.SubjectID) AS TotalSubjects
        FROM SEMESTER S
        JOIN SUBJECT SUB ON S.SemesterID = SUB.SemesterID
        WHERE ISNULL(S.DELETE_FLG, 0) = 0 AND ISNULL(SUB.DELETE_FLG, 0) = 0
        GROUP BY S.course_id
    ),

    ExamSubject AS (
        SELECT ExamID, SubjectID
        FROM EXAM_SCHEDULE
    ),

    StudentsPerCourseYear AS (
        SELECT 
            CE.StudentID,
            C.course_id,
            YEAR(C.StartTime) AS Year
        FROM CLASS_ENROLLMENT CE
        JOIN CLASS C ON CE.ClassID = C.ClassID
        WHERE YEAR(C.StartTime) = @Year
    ),

    PassedSubjects AS (
        SELECT 
            ER.StudentID,
            ES.SubjectID
        FROM EXAM_RESULT ER
        JOIN ExamSubject ES ON ER.ExamID = ES.ExamID
        WHERE ER.Status = N'Đạt'
        GROUP BY ER.StudentID, ES.SubjectID
    ),

    PassedCountPerStudent AS (
        SELECT 
            SPCY.StudentID,
            SPCY.course_id,
            SPCY.Year,
            COUNT(DISTINCT PS.SubjectID) AS PassedCount
        FROM StudentsPerCourseYear SPCY
        JOIN SEMESTER S ON S.course_id = SPCY.course_id AND ISNULL(S.DELETE_FLG, 0) = 0
        JOIN SUBJECT SUB ON SUB.SemesterID = S.SemesterID AND ISNULL(SUB.DELETE_FLG, 0) = 0
        LEFT JOIN PassedSubjects PS ON PS.StudentID = SPCY.StudentID AND PS.SubjectID = SUB.SubjectID
        GROUP BY SPCY.StudentID, SPCY.course_id, SPCY.Year
    ),

    GraduatedStudents AS (
        SELECT PCS.StudentID, PCS.course_id, PCS.Year
        FROM PassedCountPerStudent PCS
        JOIN SubjectsPerCourse SC ON PCS.course_id = SC.course_id
        WHERE PCS.PassedCount = SC.TotalSubjects
    )

    SELECT 
        C.course_id AS CourseID,
        C.course_name AS CourseName,
        SPCY.Year,
        COUNT(DISTINCT G.StudentID) AS GraduatedCount,
        COUNT(DISTINCT SPCY.StudentID) AS TotalStudents,
        CAST(COUNT(DISTINCT G.StudentID) * 100.0 / NULLIF(COUNT(DISTINCT SPCY.StudentID), 0) AS DECIMAL(5,2)) AS GraduationRatePercent
    FROM StudentsPerCourseYear SPCY
    JOIN Course C ON SPCY.course_id = C.course_id
    LEFT JOIN GraduatedStudents G ON G.StudentID = SPCY.StudentID AND G.course_id = SPCY.course_id AND G.Year = SPCY.Year
    GROUP BY C.course_id, C.course_name, SPCY.Year
    ORDER BY SPCY.Year, C.course_name;
END

