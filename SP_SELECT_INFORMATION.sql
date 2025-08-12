CREATE PROCEDURE SP_SELECT_INFORMATION
    @ID VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Prefix NVARCHAR(2) = LEFT(@ID, 2);

    IF (@Prefix = 'HV') -- Học viên
    BEGIN
        SELECT 
            StudentID AS ID,
            FullName,
            Gender,
            Address,
            Email,
            PhoneNumber
        FROM STUDENT
        WHERE StudentID = @ID;
    END
    ELSE IF (@Prefix = 'GV') -- Giáo viên
    BEGIN
        SELECT 
            TeacherID AS ID,
            FullName,
            Gender,
            Address,
            Email,
            PhoneNumber
        FROM TEACHER
        WHERE TeacherID = @ID;
    END
    ELSE IF (@Prefix = 'NV') -- Nhân viên
    BEGIN
        SELECT 
            EmployeeID AS ID,
            FullName,
            Gender,
            Address,
            Email,
            PhoneNumber
        FROM EMPLOYEE
        WHERE EmployeeID = @ID;
    END
    ELSE
    BEGIN
        RAISERROR('Mã không hợp lệ!', 16, 1);
    END
END
GO


--exec SP_SELECT_INFORMATION 'GV001'