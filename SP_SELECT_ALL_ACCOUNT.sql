CREATE OR ALTER PROCEDURE [dbo].[SP_SELECT_ALL_ACCOUNT]
    @Search NVARCHAR(100) = NULL,
    @Role NVARCHAR(50) = NULL,
    @PageIndex INT = 1,
    @PageSize INT = 30
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageIndex - 1) * @PageSize;

    -- Total count
    SELECT COUNT(*) AS TotalCount
    FROM ACCOUNT
    WHERE DELETE_FLG = 0
      AND (@Search IS NULL OR Username LIKE '%' + @Search + '%' OR Role LIKE '%' + @Search + '%')
      AND (@Role IS NULL OR Role = @Role);

    -- Data page
    SELECT Username, Role
    FROM ACCOUNT
    WHERE DELETE_FLG = 0
      AND (@Search IS NULL OR Username LIKE '%' + @Search + '%' OR Role LIKE '%' + @Search + '%')
      AND (@Role IS NULL OR Role = @Role)
    ORDER BY Username
    OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;
END
