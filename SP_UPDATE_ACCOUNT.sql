USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_ACCOUNT]    Script Date: 03/07/2025 01:16:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_UPDATE_ACCOUNT]
    @Username VARCHAR(20),
    @Password VARCHAR(30) = NULL,
    @Role VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate Role if provided
        IF @Role IS NOT NULL AND @Role NOT IN ('Admin', 'Employee', 'Teacher', 'Student')
        BEGIN
            RAISERROR('Invalid Role. Must be Admin, Employee, Teacher, or Student.', 16, 1);
            ROLLBACK;
            RETURN 0;
        END

        -- Update ACCOUNT
        UPDATE ACCOUNT
        SET Password = COALESCE(@Password, Password),
            Role = COALESCE(@Role, Role)
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
