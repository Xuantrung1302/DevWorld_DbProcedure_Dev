USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_UPDATE_NOTICE]
    @NewsID VARCHAR(10),
    @Title NVARCHAR(200),
    @Content NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE NEWSBOARD
        SET Title = @Title,
            Content = @Content
        WHERE NewsID = @NewsID;

        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK;
            RAISERROR('Notice not found.', 16, 1);
            RETURN 0;
        END

        COMMIT TRANSACTION;
        RETURN 1; -- Success
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN 0; -- Failure
    END CATCH;
END
