USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_UPDATE_INVOICE]
    @InvoiceID VARCHAR(10),
    @InvoiceDate DATETIME = NULL,
    @DueDate DATETIME = NULL,
    @Amount DECIMAL(12,2) = NULL,
    @Status NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE INVOICE
        SET
            InvoiceDate = CASE WHEN @InvoiceDate IS NOT NULL THEN @InvoiceDate ELSE InvoiceDate END,
            DueDate     =  GETDATE(),
            Amount      = CASE WHEN @Amount IS NOT NULL THEN @Amount ELSE Amount END,
            Status      = CASE WHEN @Status IS NOT NULL THEN @Status ELSE Status END
        WHERE 
            RTRIM(InvoiceID) = @InvoiceID 
            AND (DELETE_FLG IS NULL OR DELETE_FLG = 0);

        COMMIT TRANSACTION;
        RETURN 1; -- Success
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN 0; -- Failure
    END CATCH;
END