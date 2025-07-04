USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_UPDATE_EXAM_SCHEDULE]
    @ExamID UNIQUEIDENTIFIER,
    @ExamName NVARCHAR(100),
    @ExamType NVARCHAR(20),
    @ExamDateStart DATETIME,
    @ExamDateEnd DATETIME,
    @Room NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE EXAM_SCHEDULE
        SET 
            ExamName = @ExamName,
            ExamType = @ExamType,
            ExamDateStart = @ExamDateStart,
            ExamDateEnd = @ExamDateEnd,
            Room = @Room
        WHERE ExamID = @ExamID;

        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK;
            RAISERROR('Exam schedule not found.', 16, 1);
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
