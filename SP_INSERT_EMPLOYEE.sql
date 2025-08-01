USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_EMPLOYEE]    Script Date: 03/07/2025 00:20:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_INSERT_EMPLOYEE]
    @EmployeeID VARCHAR(10),
    @FullName NVARCHAR(100),
    @Gender NVARCHAR(5),
    @PhoneNumber VARCHAR(15),
    @Address NVARCHAR(200),
    @Email VARCHAR(50),
    @Username VARCHAR(20),
    @Password VARCHAR(30)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert into ACCOUNT table
        INSERT INTO ACCOUNT (Username, Password, Role, DELETE_FLG)
        VALUES (@Username, @Password, 'Employee', 0);

        -- Insert into EMPLOYEE table
        INSERT INTO EMPLOYEE (EmployeeID, FullName, Gender, PhoneNumber, Address, Email, Username, DELETE_FLG)
        VALUES (@EmployeeID, @FullName, @Gender, @PhoneNumber, @Address, @Email, @Username, 0);

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
