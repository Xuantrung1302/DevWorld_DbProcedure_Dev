USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_INVOICE]
    @StudentID VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        I.InvoiceID,
        I.StudentID,
        S.FullName,       
        CO.course_id,
        CO.course_name,
        I.InvoiceDate,
        I.DueDate,
        I.Amount,
        I.Status
    FROM INVOICE I
    LEFT JOIN COURSE CO ON I.course_id = CO.course_id
    LEFT JOIN STUDENT S ON I.StudentID = S.StudentID   
    WHERE
        (@StudentID IS NULL OR I.StudentID = @StudentID)
        AND (I.DELETE_FLG IS NULL OR I.DELETE_FLG = 0)
END
GO


