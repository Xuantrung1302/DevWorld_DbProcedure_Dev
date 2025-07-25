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
        I.InvoiceID,
        I.StudentID,
        I.SemesterID,
        C.course_id,             
        C.course_name,           
        I.InvoiceDate,
        I.DueDate,
        I.Amount,
        I.Status
    FROM INVOICE I
    LEFT JOIN SEMESTER S ON I.SemesterID = S.SemesterID
    LEFT JOIN COURSE C ON S.course_id = C.course_id
    WHERE
        (@StudentID IS NULL OR I.StudentID = @StudentID)
        AND (@SemesterID IS NULL OR I.SemesterID = @SemesterID)
        AND (@Status IS NULL OR I.Status = @Status)
        AND (I.DELETE_FLG IS NULL OR I.DELETE_FLG = 0)
END
GO

