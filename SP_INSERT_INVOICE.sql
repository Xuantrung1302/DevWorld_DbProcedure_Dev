USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_INSERT_INVOICE]
    @InvoiceID VARCHAR(10),
    @StudentID VARCHAR(10),
    @SemesterID VARCHAR(10),
    @InvoiceDate DATETIME,
    @DueDate DATETIME,
    @Amount DECIMAL(12,2),
    @Status NVARCHAR(20)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO INVOICE 
        (InvoiceID, StudentID, SemesterID, InvoiceDate, DueDate, Amount, DELETE_FLG, Status)
        VALUES
        (@InvoiceID, @StudentID, @SemesterID, @InvoiceDate, @DueDate, @Amount, 0, @Status);

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
