CREATE OR ALTER PROCEDURE [dbo].[SP_SELECT_TEACHER]
    @Search NVARCHAR(100) = NULL,
    @PageIndex INT = 1,
    @PageSize INT = 30
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageIndex - 1) * @PageSize;

    -- Total Count
    SELECT COUNT(*) AS TotalCount
    FROM TEACHER
    WHERE DELETE_FLG = 0
      AND (
          @Search IS NULL 
          OR FullName LIKE '%' + @Search + '%' 
          OR Email LIKE '%' + @Search + '%'
          OR PhoneNumber LIKE '%' + @Search + '%'
      );

    -- Paged Data
    SELECT 
        TeacherID, FullName, Gender, PhoneNumber, Address, Email, Degree, Username
    FROM TEACHER
    WHERE DELETE_FLG = 0
      AND (
          @Search IS NULL 
          OR FullName LIKE '%' + @Search + '%' 
          OR Email LIKE '%' + @Search + '%'
          OR PhoneNumber LIKE '%' + @Search + '%'
      )
    ORDER BY TeacherID
    OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;
END