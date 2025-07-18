USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_TEACHER]    Script Date: 02/07/2025 22:17:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_INSERT_TEACHER]
    @TeacherID VARCHAR(10),
    @FullName NVARCHAR(100),
    @Gender NVARCHAR(5),
    @PhoneNumber VARCHAR(15),
    @Address NVARCHAR(200),
    @Email VARCHAR(50),
    @Degree NVARCHAR(50),
    @Username VARCHAR(20),
    @Password VARCHAR(30)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert into ACCOUNT table
        INSERT INTO ACCOUNT (Username, Password, Role, DELETE_FLG)
        VALUES (@Username, @Password, 'Teacher', 0);

        -- Insert into TEACHER table
        INSERT INTO TEACHER (TeacherID, FullName, Gender, PhoneNumber, Address, Email, Degree, Username, DELETE_FLG)
        VALUES (@TeacherID, @FullName, @Gender, @PhoneNumber, @Address, @Email, @Degree, @Username, 0);

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
