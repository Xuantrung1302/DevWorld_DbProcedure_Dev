USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_INSERT_INVOICE]
    @json NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
        INSERT INTO INVOICE (
            InvoiceID,
            StudentID,
            course_id,
            InvoiceDate,
            DueDate,
            Amount,
            DELETE_FLG,
            Status
        )
        SELECT
            NEWID(), 
            JSONData.StudentID,
            JSONData.course_id,
            JSONData.InvoiceDate,
            JSONData.DueDate,
            JSONData.Amount,
            ISNULL(JSONData.DELETE_FLG, 0),
            JSONData.Status
        FROM OPENJSON(@json)
        WITH (
            StudentID NVARCHAR(10),
            course_id UNIQUEIDENTIFIER,
            InvoiceDate DATETIME,
            DueDate DATETIME,
            Amount DECIMAL(12, 2),
            DELETE_FLG BIT,
            Status NVARCHAR(20)
        ) AS JSONData;

        COMMIT TRANSACTION;
        RETURN 1;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@err, 16, 1);
        RETURN 0;
    END CATCH
END


