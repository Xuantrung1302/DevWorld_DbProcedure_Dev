USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_INVOICE]
    @StudentID VARCHAR(10) = NULL,
    @SemesterID VARCHAR(10) = NULL,
	@Status NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
		InvoiceID,
		StudentID,
		SemesterID,
		InvoiceDate,
		DueDate,
		Amount,
    Status
    FROM INVOICE
    WHERE
        (@StudentID IS NULL OR StudentID = @StudentID)
        AND (@SemesterID IS NULL OR SemesterID = @SemesterID)
        AND (@Status IS NULL OR Status = @Status)
        AND (DELETE_FLG IS NULL OR DELETE_FLG = 0)
END
GO