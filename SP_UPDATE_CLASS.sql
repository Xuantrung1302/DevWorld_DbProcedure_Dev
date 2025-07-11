USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_UPDATE_CLASS]
    @ClassID UNIQUEIDENTIFIER,
    @SubjectID VARCHAR(10),
    @ClassName VARCHAR(50),
    @StartTime DATETIME,
    @EndTime DATETIME,
    @Room VARCHAR(10),
    @TeacherID VARCHAR(10),
    @MaxSeats INT = NULL,
    @DaysOfWeek VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE CLASS
        SET 
            SubjectID = @SubjectID,
            ClassName = @ClassName,
            StartTime = @StartTime,
            EndTime = @EndTime,
            Room = @Room,
            TeacherID = @TeacherID,
            MaxSeats = @MaxSeats,
            DaysOfWeek = @DaysOfWeek
        WHERE ClassID = @ClassID;

        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK;
            RAISERROR('Class not found.', 16, 1);
            RETURN 0;
        END

        COMMIT TRANSACTION;
        RETURN 1;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN 0;
    END CATCH;
END
