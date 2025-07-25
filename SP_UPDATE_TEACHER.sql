SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_UPDATE_TEACHER]
    @TeacherID VARCHAR(10),
    @FullName NVARCHAR(100),
    @Gender NVARCHAR(5),
    @PhoneNumber VARCHAR(15),
    @Address NVARCHAR(200),
    @Email VARCHAR(50),
    @Degree NVARCHAR(50),
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
            USING (SELECT @Username AS Username, @Password AS Password, 'Teacher' AS Role) AS source
            ON target.Username = source.Username
            WHEN MATCHED THEN
                UPDATE SET Password = source.Password, Role = source.Role
            WHEN NOT MATCHED THEN
                INSERT (Username, Password, Role, DELETE_FLG)
                VALUES (source.Username, source.Password, source.Role, 0);
        END

        -- Update TEACHER
        UPDATE TEACHER
        SET FullName = @FullName,
            Gender = @Gender,
            PhoneNumber = @PhoneNumber,
            Address = @Address,
            Email = @Email,
            Degree = @Degree,
            Username = COALESCE(@Username, Username)
        WHERE TeacherID = @TeacherID AND DELETE_FLG = 0;

        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK;
            RAISERROR('Teacher not found or already deleted.', 16, 1);
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
