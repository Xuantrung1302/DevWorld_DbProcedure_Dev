USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_INSERT_NOTICE]
    @Title NVARCHAR(200),
    @Content NVARCHAR(MAX),
    @PostDate DATETIME,
    @PostedBy VARCHAR(20)
AS
BEGIN
    --SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO NEWSBOARD (NewsID, Title, Content, PostDate, PostedBy)
        VALUES (NewID(), @Title, @Content, @PostDate, @PostedBy);

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

