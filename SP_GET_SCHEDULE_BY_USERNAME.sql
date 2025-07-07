USE [DEV_ACADEMY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_GET_SCHEDULE_BY_USERNAME]
    @Username VARCHAR(20)
AS
BEGIN

    DECLARE @Role VARCHAR(20);

    SELECT @Role = Role 
    FROM ACCOUNT 
    WHERE Username = @Username AND DELETE_FLG = 0;

    IF @Role IS NULL
    BEGIN
        RAISERROR('Username does not exist.', 16, 1);
        RETURN;
    END

    IF @Role = 'Student'
    BEGIN
        SELECT 
            CS.*
        FROM CLASS_SCHEDULE CS
        INNER JOIN CLASS_ENROLLMENT CE ON CS.ClassID = CE.ClassID
        INNER JOIN STUDENT S ON CE.StudentID = S.StudentID
        WHERE S.Username = @Username;
    END
    ELSE IF @Role = 'Teacher'
    BEGIN
        SELECT 
            CS.*
        FROM CLASS_SCHEDULE CS
        INNER JOIN CLASS C ON CS.ClassID = C.ClassID
        INNER JOIN TEACHER T ON C.TeacherID = T.TeacherID
        WHERE T.Username = @Username;
    END

    ELSE
    BEGIN
        SELECT * FROM CLASS_SCHEDULE;
    END
END
GO
