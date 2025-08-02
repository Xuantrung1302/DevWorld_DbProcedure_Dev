CREATE or alter PROCEDURE [dbo].[SP_INSERT_MESSAGE]
    @SenderID INT,
    @ReceiverID INT,
    @MessageContent NVARCHAR(1000), -- Giả sử độ dài tối đa của nội dung tin nhắn là 1000 ký tự
    @SentDateTime DATETIME
AS
BEGIN
    --SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [DEV_ACADEMY].[dbo].[Messages]
            ([SenderID], [ReceiverID], [MessageContent], [SentDateTime])
        VALUES
            (@SenderID, @ReceiverID, @MessageContent, @SentDateTime);

        -- Trả về MessageID của tin nhắn vừa chèn (nếu cần)
        SELECT SCOPE_IDENTITY() AS MessageID;
    END TRY
    BEGIN CATCH
        -- Xử lý lỗi nếu có
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO