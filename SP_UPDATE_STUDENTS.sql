USE [HELLO_ACADEMY]
GO

ALTER PROCEDURE [dbo].[SP_UPDATE_STUDENTS]
    @StudentID VARCHAR(10),
    @FullName NVARCHAR(100),
    @BirthDate DATETIME,
    @Gender NVARCHAR(10),
    @Address NVARCHAR(200),
    @PhoneNumber VARCHAR(15),
    @Email VARCHAR(50),
    @EnrollmentDate DATE = NULL,
    @Username VARCHAR(20) = NULL,
    @Password VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Debug giá trị tham số
        PRINT 'Received StudentID: ' + @StudentID;
        PRINT 'Received BirthDate: ' + ISNULL(CONVERT(NVARCHAR(30), @BirthDate, 121), 'NULL');

        -- Nếu không có @Username, chỉ cập nhật thông tin học viên
        IF @Username IS NULL
        BEGIN
            UPDATE STUDENT
            SET FullName = @FullName,
                BirthDate = ISNULL(@BirthDate, BirthDate),
                Gender = @Gender,
                Address = @Address,
                PhoneNumber = @PhoneNumber,
                Email = @Email,
                EnrollmentDate = ISNULL(@EnrollmentDate, EnrollmentDate)
            WHERE StudentID = @StudentID;
        END
        ELSE
        BEGIN
            -- Cập nhật hoặc thêm tài khoản
            MERGE INTO ACCOUNT AS target
            USING (SELECT @Username AS Username, @Password AS Password) AS source
            ON target.Username = source.Username
            WHEN MATCHED THEN
                UPDATE SET target.Password = source.Password
            WHEN NOT MATCHED THEN
                INSERT (Username, Password, Role)
                VALUES (source.Username, source.Password, 'Student');

            -- Cập nhật thông tin học viên
            UPDATE STUDENT
            SET FullName = @FullName,
                BirthDate = ISNULL(@BirthDate, BirthDate),
                Gender = @Gender,
                Address = @Address,
                PhoneNumber = @PhoneNumber,
                Email = @Email,
                EnrollmentDate = ISNULL(@EnrollmentDate, EnrollmentDate)
            WHERE StudentID = @StudentID;
        END

        RETURN 1; -- Thành công
    END TRY
    BEGIN CATCH
        PRINT 'Error: ' + ERROR_MESSAGE();
        RETURN 0; -- Thất bại
    END CATCH
END
GO


