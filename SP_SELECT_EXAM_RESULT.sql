USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_EXAM_RESULT]
    @ClassID UNIQUEIDENTIFIER = NULL,
    @SubjectID VARCHAR(10) = NULL,
    @CourseID UNIQUEIDENTIFIER = NULL
AS
BEGIN
    --SET NOCOUNT ON;

    SELECT 
        ER.ResultID,
        E.ExamName,
        C.ClassName,
        S.SubjectName,
        Se.SemesterName,
        Co.course_name AS CourseName,
		St.StudentID,
        St.FullName AS StudentName,
        ER.Score,
        ER.Status,
        ER.EnteredBy,
        ER.GradingDate
    FROM EXAM_RESULT ER
    INNER JOIN EXAM_SCHEDULE E ON ER.ExamID = E.ExamID
    INNER JOIN CLASS C ON E.ClassID = C.ClassID
    INNER JOIN SUBJECT S ON E.SubjectID = S.SubjectID
    INNER JOIN SEMESTER Se ON S.SemesterID = Se.SemesterID
    INNER JOIN COURSE Co ON Se.course_id = Co.course_id
    INNER JOIN STUDENT St ON ER.StudentID = St.StudentID
    WHERE ER.DELETE_FLG = 0
      AND (@ClassID IS NULL OR C.ClassID = @ClassID)
      AND (@SubjectID IS NULL OR S.SubjectID = @SubjectID)
      AND (@CourseID IS NULL OR Co.course_id = @CourseID)
    ORDER BY ER.GradingDate DESC;
END
GO
