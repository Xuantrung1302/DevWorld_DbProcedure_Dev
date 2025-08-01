USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_STUDENT]    Script Date: 02/07/2025 22:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_DELETE_STUDENT]
    @StudentID VARCHAR(10),
    @Username VARCHAR(20)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Update DELETE_FLG in ACCOUNT
        UPDATE ACCOUNT
        SET DELETE_FLG = 1
        WHERE Username = @Username AND Role = 'Student';

        -- Update DELETE_FLG in STUDENT
        UPDATE STUDENT
        SET DELETE_FLG = 1
        WHERE StudentID = @StudentID AND DELETE_FLG = 0;

        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK;
            RAISERROR('Student not found or already deleted.', 16, 1);
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
