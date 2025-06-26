ALTER PROCEDURE [dbo].[SP_GetInvoiceByStudentID]
    @StudentID VARCHAR(10),
	@SemesterID VARCHAR(10) = null
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        InvoiceID,
        I.StudentID,
		S.FullName,
        SemesterID,
        InvoiceDate,
        Amount,
        Paid
    FROM [dbo].[INVOICE] I
		INNER JOIN STUDENT S ON S.StudentID = I.StudentID
    WHERE I.StudentID = @StudentID AND( SemesterID = @SemesterID OR @SemesterID is null);

    RETURN 0;
END;
GO

--EXEC SP_GetInvoiceByStudentID 'HV24010207', 'KY2403'

--SELECT * FROM STUDENT

--GO
--SELECT * FROM SEMESTER