USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_EXAM_SCHEDULE]
    @ExamID UNIQUEIDENTIFIER,
    @ClassID UNIQUEIDENTIFIER,
    @ExamName NVARCHAR(100),
    @ExamType NVARCHAR(20),
    @ExamDateStart DATETIME,
    @ExamDateEnd DATETIME,
    @Room NVARCHAR(100),
    @CreatedBy VARCHAR(10),
    @CreatedDate DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO EXAM_SCHEDULE 
        (ExamID, ClassID, ExamName, ExamType, ExamDateStart, ExamDateEnd, Room, CreatedBy, CreatedDate)
        VALUES 
        (@ExamID, @ClassID, @ExamName, @ExamType, @ExamDateStart, @ExamDateEnd, @Room, @CreatedBy, 
         COALESCE(@CreatedDate, GETDATE()));

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
