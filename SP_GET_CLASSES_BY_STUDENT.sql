USE [DEV_ACADEMY]
GO

ALTER PROCEDURE [dbo].[SP_GET_CLASSES_BY_STUDENT]
    @StudentID VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        C.ClassID,
        C.ClassName,
        C.SubjectID,
        S.SemesterID,
        C.StartTime,
        C.EndTime,
        C.Room
    FROM CLASS_ENROLLMENT CE
    INNER JOIN CLASS C ON CE.ClassID = C.ClassID
    INNER JOIN SUBJECT S ON C.SubjectID = S.SubjectID
    WHERE CE.StudentID = @StudentID
END
GO
