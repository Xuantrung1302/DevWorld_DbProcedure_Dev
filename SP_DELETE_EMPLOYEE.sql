USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_EMPLOYEE]    Script Date: 03/07/2025 00:48:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_DELETE_EMPLOYEE]
    @EmployeeID VARCHAR(10),
    @Username VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Update DELETE_FLG in ACCOUNT
        UPDATE ACCOUNT
        SET DELETE_FLG = 1
        WHERE Username = @Username AND Role = 'Employee';

        -- Update DELETE_FLG in EMPLOYEE
        UPDATE EMPLOYEE
        SET DELETE_FLG = 1
        WHERE EmployeeID = @EmployeeID AND DELETE_FLG = 0;

        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK;
            RAISERROR('Employee not found or already deleted.', 16, 1);
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
