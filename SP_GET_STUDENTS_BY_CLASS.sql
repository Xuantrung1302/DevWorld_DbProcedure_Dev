USE [DEV_ACADEMY]
GO

ALTER PROCEDURE [dbo].[SP_GET_STUDENTS_BY_CLASS]
    @ClassID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        S.StudentID,
        S.FullName,
        S.Gender,
        S.PhoneNumber,
        S.Email,
        S.EnrollmentDate
    FROM CLASS_ENROLLMENT CE
    INNER JOIN STUDENT S ON CE.StudentID = S.StudentID
    WHERE CE.ClassID = @ClassID
END
GO
