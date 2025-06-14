USE [HELLO_ACADEMY]
GO

/****** Object:  StoredProcedure [dbo].[SP_SELECT_SEARCH_EMPLOYEE]    Script Date: 2025/06/15 04:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Modified date: <2025-06-15>
-- Description:	<Danh sách nhân viên trong bảng EMPLOYEE>
-- =============================================
ALTER PROCEDURE [dbo].[SP_SELECT_SEARCH_EMPLOYEE]
    @EmployeeID VARCHAR(10) = NULL,
    @FullName NVARCHAR(100) = NULL,
    @Position NVARCHAR(50) = NULL
AS
BEGIN
    SELECT 
        E.EmployeeID,
        E.FullName,
        E.Gender,
        E.PhoneNumber,
        E.Email,
        E.Position,
        A.Username,
        A.Password
    FROM EMPLOYEE E
    JOIN ACCOUNT A
        ON E.Username = A.Username
    WHERE (@EmployeeID IS NULL OR E.EmployeeID LIKE '%' + @EmployeeID + '%')
        AND (@FullName IS NULL OR E.FullName LIKE '%' + @FullName + '%')
        AND (@Position IS NULL OR E.Position LIKE '%' + @Position + '%')
END
GO