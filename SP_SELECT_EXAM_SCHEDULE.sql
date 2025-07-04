USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_EXAM_SCHEDULE]
    @SemesterID VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        E.ExamID,
        C.ClassName,
        E.ExamName,
        E.ExamType,
        E.ExamDateStart,
        E.ExamDateEnd,
        E.Room,
        E.CreatedBy,
        Emp.FullName AS CreatedByName,
        E.CreatedDate
    FROM EXAM_SCHEDULE E
    INNER JOIN CLASS C ON E.ClassID = C.ClassID
    INNER JOIN SUBJECT Subj ON C.SubjectID = Subj.SubjectID
    INNER JOIN SEMESTER S ON Subj.SemesterID = S.SemesterID
    INNER JOIN EMPLOYEE Emp ON E.CreatedBy = Emp.EmployeeID
    WHERE (@SemesterID IS NULL OR S.SemesterID = @SemesterID)
    ORDER BY E.ExamDateStart;
END
