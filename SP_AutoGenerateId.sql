USE [HELLO_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_AutoGenerateId]    Script Date: 14/06/2025 12:37:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- 1. SP_AutoGenerateId
ALTER PROCEDURE [dbo].[SP_AutoGenerateId]
    @NgayBD DATE,
    @Prefix NVARCHAR(10),  -- Tham số đầu vào cho tiền tố (GV, HV, NV, PG, LH, KH)
    @NewID NVARCHAR(50) OUTPUT
AS
BEGIN
    DECLARE @BasePrefix NVARCHAR(20) = @Prefix + FORMAT(@NgayBD, 'yyMMdd');
    DECLARE @MaxNumber INT = 0;

    -- Tự động sinh ID cho Giáo viên (GV)
    IF @Prefix = 'GV'
    BEGIN
        SELECT @MaxNumber = MAX(CAST(SUBSTRING(TeacherID, LEN(@BasePrefix) + 1, LEN(TeacherID) - LEN(@BasePrefix)) AS INT))
        FROM TEACHER
        WHERE TeacherID LIKE @BasePrefix + '%';
    END
    -- Tự động sinh ID cho Học viên (HV)
    ELSE IF @Prefix = 'HV'
    BEGIN
        SELECT @MaxNumber = MAX(CAST(SUBSTRING(StudentID, LEN(@BasePrefix) + 1, LEN(StudentID) - LEN(@BasePrefix)) AS INT))
        FROM STUDENT
        WHERE StudentID LIKE @BasePrefix + '%';
    END
    -- Tự động sinh ID cho Nhân viên (NV)
    ELSE IF @Prefix = 'NV'
    BEGIN
        SELECT @MaxNumber = MAX(CAST(SUBSTRING(EmployeeID, LEN(@BasePrefix) + 1, LEN(EmployeeID) - LEN(@BasePrefix)) AS INT))
        FROM EMPLOYEE
        WHERE EmployeeID LIKE @BasePrefix + '%';
    END
    -- Tự động sinh ID cho Phieu ghi danh (PG) - Thay bằng EnrollmentID
    ELSE IF @Prefix = 'PG'
    BEGIN
        SELECT @MaxNumber = MAX(CAST(SUBSTRING(EnrollmentID, LEN(@BasePrefix) + 1, LEN(EnrollmentID) - LEN(@BasePrefix)) AS INT))
        FROM ENROLLMENT
        WHERE EnrollmentID LIKE @BasePrefix + '%';
    END
    -- Tự động sinh ID cho Lớp học (LH)
    ELSE IF @Prefix = 'LH'
    BEGIN
        SELECT @MaxNumber = MAX(CAST(SUBSTRING(ClassID, LEN(@BasePrefix) + 1, LEN(ClassID) - LEN(@BasePrefix)) AS INT))
        FROM CLASS
        WHERE ClassID LIKE @BasePrefix + '%';
    END
    -- Tự động sinh ID cho Khóa học (KH)
    ELSE IF @Prefix = 'KH'
    BEGIN
        DECLARE @KHBasePrefix NVARCHAR(2) = 'KH';
        SELECT @MaxNumber = MAX(CAST(SUBSTRING(SemesterID, 3, LEN(SemesterID) - 2) AS INT))
        FROM SEMESTER
        WHERE SemesterID LIKE @KHBasePrefix + '%';
    END

    IF @MaxNumber IS NULL
    BEGIN
        SET @MaxNumber = 0;
    END
    
    SET @NewID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber + 1 AS NVARCHAR), 2);
END
