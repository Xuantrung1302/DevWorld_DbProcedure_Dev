USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_ACCOUNT]    Script Date: 03/07/2025 01:01:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_INSERT_ACCOUNT]
    @Username VARCHAR(20),
    @Password VARCHAR(30),
    @Role VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate Role
        IF @Role NOT IN ('Admin', 'Employee', 'Teacher', 'Student')
        BEGIN
            RAISERROR('Invalid Role. Must be Admin, Employee, Teacher, or Student.', 16, 1);
            ROLLBACK;
            RETURN 0;
        END

        -- Check if Username already exists
        IF EXISTS (SELECT 1 FROM ACCOUNT WHERE Username = @Username AND DELETE_FLG = 0)
        BEGIN
            RAISERROR('Username already exists.', 16, 1);
            ROLLBACK;
            RETURN 0;
        END

        -- Insert into ACCOUNT table
        INSERT INTO ACCOUNT (Username, Password, Role, DELETE_FLG)
        VALUES (@Username, @Password, @Role, 0);

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
