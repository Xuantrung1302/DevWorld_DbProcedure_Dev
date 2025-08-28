CREATE OR ALTER PROCEDURE [dbo].[SP_CreateConversation]
    @SenderID VARCHAR(10),
    @ReceiverID VARCHAR(10)
AS
BEGIN
    --SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO Messages (MessageID, SenderID, ReceiverID, MessageContent, SentDateTime)
        VALUES (NEWID(), @SenderID, @ReceiverID, N'Xin chào!', GETDATE());
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
