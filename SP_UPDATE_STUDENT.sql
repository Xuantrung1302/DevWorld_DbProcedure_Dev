USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_STUDENT]    Script Date: 02/07/2025 22:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_UPDATE_STUDENT]
    @StudentID VARCHAR(10),
    @FullName NVARCHAR(100),
    @Gender NVARCHAR(10),
    @Address NVARCHAR(200),
    @PhoneNumber VARCHAR(15),
    @Email VARCHAR(50),
    @BirthDate DATE,
    @EnrollmentDate DATE = NULL,
    @Status NVARCHAR(20) = NULL,
    @Username VARCHAR(20) = NULL,
    @Password VARCHAR(30) = NULL
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Update ACCOUNT if Username and Password are provided
        IF @Username IS NOT NULL AND @Password IS NOT NULL
        BEGIN
            MERGE INTO ACCOUNT AS target
            USING (SELECT @Username AS Username, @Password AS Password, 'Student' AS Role) AS source
            ON target.Username = source.Username
            WHEN MATCHED THEN
                UPDATE SET Password = source.Password, Role = source.Role
            WHEN NOT MATCHED THEN
                INSERT (Username, Password, Role, DELETE_FLG)
                VALUES (source.Username, source.Password, source.Role, 0);
        END

        -- Update STUDENT
        UPDATE STUDENT
        SET FullName = @FullName,
            Gender = @Gender,
            Address = @Address,
            PhoneNumber = @PhoneNumber,
            Email = @Email,
            BirthDate = @BirthDate,
            EnrollmentDate = COALESCE(@EnrollmentDate, EnrollmentDate),
            Status = COALESCE(@Status, Status),
            Username = COALESCE(@Username, Username)
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
