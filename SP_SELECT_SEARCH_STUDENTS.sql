USE [HELLO_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_SEARCH_STUDENTS]    Script Date: 14/06/2025 12:45:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 29. SP_SELECT_SEARCH_STUDENTS
ALTER PROCEDURE [dbo].[SP_SELECT_SEARCH_STUDENTS]
    @StudentID VARCHAR(10) = NULL,
    @FullName NVARCHAR(100) = NULL,
    @EnrollmentDateStart DATE = NULL,
    @EnrollmentDateEnd DATE = NULL,
    @Gender NVARCHAR(10) = NULL
AS
BEGIN
    SELECT S.StudentID, S.FullName, S.BirthDate, S.Gender, S.PhoneNumber, S.Address, S.EnrollmentDate, S.Email, A.Username, A.Password
    FROM STUDENT S
    LEFT JOIN ACCOUNT A ON S.Username = A.Username
    WHERE (@StudentID IS NULL OR S.StudentID LIKE '%' + @StudentID + '%') 
        AND (@FullName IS NULL OR S.FullName LIKE '%' + @FullName + '%') 
        AND (@EnrollmentDateStart IS NULL OR @EnrollmentDateEnd IS NULL OR S.EnrollmentDate BETWEEN @EnrollmentDateStart AND @EnrollmentDateEnd)
        AND (@Gender IS NULL OR S.Gender LIKE '%' + @Gender + '%');
END

