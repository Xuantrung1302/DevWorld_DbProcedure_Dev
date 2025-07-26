USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [SP_GET_COMPLETED_COURSES_BY_STUDENT]
    @StudentID VARCHAR(10)
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

    CoursesOfStudent AS (
        SELECT DISTINCT C.course_id
        FROM CLASS_ENROLLMENT CE
        JOIN CLASS C ON CE.ClassID = C.ClassID
        WHERE CE.StudentID = @StudentID
    ),

    PassedSubjects AS (
        SELECT 
            ER.StudentID,
            ES.SubjectID
        FROM EXAM_RESULT ER
        JOIN ExamSubject ES ON ER.ExamID = ES.ExamID
        WHERE ER.StudentID = @StudentID AND ER.Status = N'Đạt'
    ),

    PassedCountPerCourse AS (
        SELECT 
            COS.course_id,
            COUNT(DISTINCT PS.SubjectID) AS PassedCount
        FROM CoursesOfStudent COS
        JOIN SEMESTER S ON S.course_id = COS.course_id AND ISNULL(S.DELETE_FLG, 0) = 0
        JOIN SUBJECT SUB ON SUB.SemesterID = S.SemesterID AND ISNULL(SUB.DELETE_FLG, 0) = 0
        LEFT JOIN PassedSubjects PS ON PS.SubjectID = SUB.SubjectID
        GROUP BY COS.course_id
    )

    SELECT 
        C.course_id AS CourseID,
        C.course_code AS CourseCode,
        C.course_name AS CourseName
    FROM PassedCountPerCourse PCC
    JOIN SubjectsPerCourse SPC ON PCC.course_id = SPC.course_id
    JOIN COURSE C ON C.course_id = PCC.course_id
    WHERE PCC.PassedCount = SPC.TotalSubjects
END
select * from EXAM_RESULT
exec [SP_GET_COMPLETED_COURSES_BY_STUDENT] @StudentID = 'HV00000001'

