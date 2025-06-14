GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_STUDENTS]    Script Date: 2025/01/15 9:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-10-03>
-- Description:	<Thêm học viên-chính thức: có tài khoản, tiềm năng: không có tài khoản>
-- =============================================
ALTER PROCEDURE [dbo].[SP_INSERT_STUDENTS]
(
	@StudentID VARCHAR(10),
    @FullName NVARCHAR(100),
    @Gender NVARCHAR(10),
    @Address NVARCHAR(200),
    @PhoneNumber VARCHAR(15),
    @Email VARCHAR(50),
    @EnrollmentDate DATE,
	@BirthDate DATE,
    @Username VARCHAR(20),
    @Password VARCHAR(20)
)
AS
BEGIN
    BEGIN
        INSERT INTO ACCOUNT(Username, Password)
        VALUES (@Username, @Password);

        INSERT INTO STUDENT(StudentID, FullName, Gender, Address, PhoneNumber, Email, EnrollmentDate, BirthDate, Username)
        VALUES (@StudentID, @FullName, @Gender, @Address, @PhoneNumber, @Email, @EnrollmentDate, @BirthDate, @Username);
    END
END
