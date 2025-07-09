USE [DEV_ACADEMY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_GET_SCHEDULE_BY_USERNAME]
    @Username VARCHAR(20),
    @Code VARCHAR(20) = NULL,
    @SemesterID VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;

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
    ELSE IF @Role IN ('Employee', 'Admin')
    BEGIN
        IF @Code IS NULL OR @SemesterID IS NULL
        BEGIN
            RAISERROR('Employee must provide @Code and @SemesterID.', 16, 1);
            RETURN;
        END

        -- Check if @Code is TeacherID
        IF EXISTS (SELECT 1 FROM TEACHER WHERE TeacherID = @Code)
        BEGIN
            SELECT 
                CS.*
            FROM CLASS_SCHEDULE CS
            INNER JOIN CLASS C ON CS.ClassID = C.ClassID
            INNER JOIN SUBJECT SJ ON C.SubjectID = SJ.SubjectID
            WHERE C.TeacherID = @Code AND SJ.SemesterID = @SemesterID;
        END
        -- Check if @Code is StudentID
        ELSE IF EXISTS (SELECT 1 FROM STUDENT WHERE StudentID = @Code)
        BEGIN
            SELECT 
                CS.*
            FROM CLASS_SCHEDULE CS
            INNER JOIN CLASS_ENROLLMENT CE ON CS.ClassID = CE.ClassID
            INNER JOIN CLASS C ON CS.ClassID = C.ClassID
            INNER JOIN SUBJECT SJ ON C.SubjectID = SJ.SubjectID
            WHERE CE.StudentID = @Code AND SJ.SemesterID = @SemesterID;
        END
        ELSE
        BEGIN
            RAISERROR('Invalid @Code: not found in TEACHER or STUDENT.', 16, 1);
            RETURN;
        END
    END
    ELSE
    BEGIN
        SELECT * FROM CLASS_SCHEDULE;
    END
END
GO
