USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_EXAM_SCHEDULE]
    @CourseID UNIQUEIDENTIFIER = NULL,
    @SubjectID UNIQUEIDENTIFIER = NULL
AS
BEGIN

    SELECT 
        E.ExamID,
        C.ClassName,
        S.SubjectName,
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
    INNER JOIN COURSE CR ON C.course_id = CR.course_id
    INNER JOIN SEMESTER Se ON CR.course_id = Se.course_id
    INNER JOIN SUBJECT S ON S.SemesterID = Se.SemesterID
    INNER JOIN EMPLOYEE Emp ON E.CreatedBy = Emp.EmployeeID
    WHERE
        (@CourseID IS NULL OR CR.course_id = @CourseID)
        AND (@SubjectID IS NULL OR S.SubjectID = @SubjectID)
    ORDER BY E.ExamDateStart;
END
