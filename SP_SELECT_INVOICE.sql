USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_INVOICE]
    @StudentID VARCHAR(10) = NULL,
    @SemesterID VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        StudentID,
        SemesterID,
        SUM(Amount) AS TotalDebt
    FROM INVOICE
    WHERE
        (@StudentID IS NULL OR StudentID = @StudentID)
        AND (@SemesterID IS NULL OR SemesterID = @SemesterID)
        AND Status = N'Chua dong'
        AND (DELETE_FLG IS NULL OR DELETE_FLG = 0)
    GROUP BY 
        StudentID, SemesterID
END
GO
