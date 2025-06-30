ALTER PROCEDURE SP_UpdateInvoice
    @InvoiceID VARCHAR(10),
    @InvoiceDate DATETIME,
    @Amount DECIMAL(10, 2),
    @Paid BIT
AS
BEGIN
    --SET NOCOUNT ON;

    UPDATE [dbo].[INVOICE]
    SET 
        InvoiceDate = @InvoiceDate,
        Amount = @Amount,
        Paid = @Paid
    WHERE InvoiceID = @InvoiceID;

    --IF @@ROWCOUNT = 0
    --    THROW 50001, 'Không tìm thấy hóa đơn để cập nhật.', 1;

END;
GO