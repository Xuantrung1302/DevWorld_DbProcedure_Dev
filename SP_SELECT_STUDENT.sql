SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SELECT_STUDENT]
    @Search NVARCHAR(100) = NULL,
    @PageIndex INT = 1,
    @PageSize INT = 30
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageIndex - 1) * @PageSize;

    SELECT COUNT(*) AS TotalCount
    FROM STUDENT
    WHERE DELETE_FLG = 0
      AND (
          @Search IS NULL 
          OR FullName LIKE '%' + @Search + '%' 
          OR Email LIKE '%' + @Search + '%'
          OR PhoneNumber LIKE '%' + @Search + '%'
      );

    SELECT 
        StudentID, FullName, Gender, Address, PhoneNumber, Email, BirthDate, EnrollmentDate, Status, Username
    FROM STUDENT
    WHERE DELETE_FLG = 0
      AND (
          @Search IS NULL 
          OR FullName LIKE '%' + @Search + '%' 
          OR Email LIKE '%' + @Search + '%'
          OR PhoneNumber LIKE '%' + @Search + '%'
      )
    ORDER BY StudentID
    OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;
END