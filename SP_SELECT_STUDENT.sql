USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_STUDENT]    Script Date: 02/07/2025 21:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_STUDENT]
    @StudentID VARCHAR(10) = NULL,
    @FullName NVARCHAR(100) = NULL,
    @Gender NVARCHAR(10) = NULL,
    @EnrollmentDateStart DATE = NULL,
    @EnrollmentDateEnd DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT S.StudentID, S.FullName, S.Gender, S.Address, S.PhoneNumber, S.Email, S.BirthDate, S.EnrollmentDate, S.Status, S.Username
    FROM STUDENT S
    WHERE (S.DELETE_FLG = 0)
        AND (@StudentID IS NULL OR S.StudentID LIKE '%' + @StudentID + '%')
        AND (@FullName IS NULL OR S.FullName LIKE '%' + @FullName + '%')
        AND (@Gender IS NULL OR S.Gender = @Gender)
        AND (@EnrollmentDateStart IS NULL OR @EnrollmentDateEnd IS NULL OR S.EnrollmentDate BETWEEN @EnrollmentDateStart AND @EnrollmentDateEnd);
END
