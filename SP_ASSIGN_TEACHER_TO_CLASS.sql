USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ASSIGN_TEACHER_TO_CLASS]
    @ClassID UNIQUEIDENTIFIER,
    @TeacherID VARCHAR(10)
AS
BEGIN
    --SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM CLASS WHERE ClassID = @ClassID)
        BEGIN
            RAISERROR('Class does not exist.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END


        IF NOT EXISTS (SELECT 1 FROM TEACHER WHERE TeacherID = @TeacherID AND DELETE_FLG = 0)
        BEGIN
            RAISERROR('Teacher does not exist.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END


        IF EXISTS (SELECT 1 FROM CLASS WHERE ClassID = @ClassID AND TeacherID IS NOT NULL)
        BEGIN
            RAISERROR('This class already has a teacher assigned.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE CLASS
        SET TeacherID = @TeacherID
        WHERE ClassID = @ClassID;

        COMMIT TRANSACTION;
        PRINT 'Teacher assigned to class successfully.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Err, 16, 1);
    END CATCH
END
GO
