CREATE OR ALTER PROCEDURE [dbo].[SP_SELECT_EMPLOYEE]
    @Search NVARCHAR(100) = NULL,
    @PageIndex INT = 1,
    @PageSize INT = 30
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageIndex - 1) * @PageSize;

    -- Total count
    SELECT COUNT(*) AS TotalCount
    FROM EMPLOYEE
    WHERE DELETE_FLG = 0
      AND (
          @Search IS NULL
          OR FullName LIKE '%' + @Search + '%'
          OR Email LIKE '%' + @Search + '%'
          OR PhoneNumber LIKE '%' + @Search + '%'
      );

    -- Data page
    SELECT 
        EmployeeID, FullName, Gender, PhoneNumber, Address, Email, Username
    FROM EMPLOYEE
    WHERE DELETE_FLG = 0
      AND (
          @Search IS NULL
          OR FullName LIKE '%' + @Search + '%'
          OR Email LIKE '%' + @Search + '%'
          OR PhoneNumber LIKE '%' + @Search + '%'
      )
    ORDER BY EmployeeID
    OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;
END
