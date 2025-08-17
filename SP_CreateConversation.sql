CREATE OR ALTER PROCEDURE [dbo].[SP_CreateConversation]
    @SenderID varchar(10),
    @ReceiverID varchar(10)
AS
BEGIN
    --SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO Messages (SenderID, ReceiverID, MessageContent, SentDateTime)
        VALUES (@SenderID, @ReceiverID, NULL, NULL);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
