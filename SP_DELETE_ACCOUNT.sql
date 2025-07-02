USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_ACCOUNT]    Script Date: 03/07/2025 01:06:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_DELETE_ACCOUNT]
    @Username VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check for dependencies in STUDENT, TEACHER, EMPLOYEE
        IF EXISTS (SELECT 1 FROM STUDENT WHERE Username = @Username AND DELETE_FLG = 0)
           OR EXISTS (SELECT 1 FROM TEACHER WHERE Username = @Username AND DELETE_FLG = 0)
           OR EXISTS (SELECT 1 FROM EMPLOYEE WHERE Username = @Username AND DELETE_FLG = 0)
        BEGIN
            RAISERROR('Cannot delete account because it is referenced by an active Student, Teacher, or Employee record.', 16, 1);
            ROLLBACK;
            RETURN 0;
        END

        -- Update DELETE_FLG in ACCOUNT
        UPDATE ACCOUNT
        SET DELETE_FLG = 1
        WHERE Username = @Username AND DELETE_FLG = 0;

        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK;
            RAISERROR('Account not found or already deleted.', 16, 1);
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
