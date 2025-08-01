SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 17. SP_LOGIN
ALTER PROCEDURE [dbo].[SP_LOGIN]
    @Username VARCHAR(20),
    @Password VARCHAR(20)
AS
BEGIN
    SELECT E.EmployeeID, S.StudentID, T.TeacherID, A.Username, A.Password, A.Role,
           E.FullName AS EmployeeName, S.FullName AS StudentName, T.FullName AS TeacherName,
		   Password
    FROM ACCOUNT A
    LEFT JOIN EMPLOYEE E ON E.Username = A.Username
    LEFT JOIN STUDENT S ON S.Username = A.Username
    LEFT JOIN TEACHER T ON T.Username = A.Username
    WHERE A.Username = @Username AND A.Password = @Password;
END