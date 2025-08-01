USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_STUDENT]    Script Date: 02/07/2025 21:41:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_INSERT_STUDENT]
    @StudentID VARCHAR(10),
    @FullName NVARCHAR(100),
    @Gender NVARCHAR(10),
    @Address NVARCHAR(200),
    @PhoneNumber VARCHAR(15),
    @Email VARCHAR(50),
    @BirthDate DATE,
    @EnrollmentDate DATE,
    @Username VARCHAR(20),
    @Password VARCHAR(30)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert into ACCOUNT table
        INSERT INTO ACCOUNT (Username, Password, Role, DELETE_FLG)
        VALUES (@Username, @Password, 'Student', 0);

        -- Insert into STUDENT table
        INSERT INTO STUDENT (StudentID, FullName, Gender, Address, PhoneNumber, Email, BirthDate, EnrollmentDate, Status, Username, DELETE_FLG)
        VALUES (@StudentID, @FullName, @Gender, @Address, @PhoneNumber, @Email, @BirthDate, @EnrollmentDate, N'Đang học', @Username, 0);

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
