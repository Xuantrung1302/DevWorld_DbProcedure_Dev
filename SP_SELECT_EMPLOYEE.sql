USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_EMPLOYEE]    Script Date: 03/07/2025 00:33:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_EMPLOYEE]
    @EmployeeID VARCHAR(10) = NULL,
    @FullName NVARCHAR(100) = NULL,
    @Gender NVARCHAR(5) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT E.EmployeeID, E.FullName, E.Gender, E.PhoneNumber, E.Address, E.Email, E.Username
    FROM EMPLOYEE E
    WHERE (E.DELETE_FLG = 0)
        AND (@EmployeeID IS NULL OR E.EmployeeID LIKE '%' + @EmployeeID + '%')
        AND (@FullName IS NULL OR E.FullName LIKE '%' + @FullName + '%')
        AND (@Gender IS NULL OR E.Gender = @Gender);
END
