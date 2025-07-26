USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_EXAM_SCHEDULE_BY_STUDENT]
    @StudentID VARCHAR(10) = NULL,
    @CourseID UNIQUEIDENTIFIER = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        E.ExamID,
        C.ClassName,
        E.SubjectID,
        S.SubjectName,
        E.ExamName,
        E.ExamType,
        E.ExamDateStart,
        E.ExamDateEnd,
        E.Room,
        E.CreatedBy,
        Emp.FullName AS CreatedByName,
        E.CreatedDate
    FROM STUDENT ST
    INNER JOIN CLASS_ENROLLMENT CE ON ST.StudentID = CE.StudentID
    INNER JOIN CLASS C ON CE.ClassID = C.ClassID
    INNER JOIN COURSE CR ON C.course_id = CR.course_id
    INNER JOIN EXAM_SCHEDULE E ON C.ClassID = E.ClassID
    LEFT JOIN SUBJECT S ON E.SubjectID = S.SubjectID
    INNER JOIN EMPLOYEE Emp ON E.CreatedBy = Emp.EmployeeID
    WHERE
        (@StudentID IS NULL OR ST.StudentID = @StudentID)
        AND (@CourseID IS NULL OR CR.course_id = @CourseID)
    ORDER BY E.ExamDateStart;
END