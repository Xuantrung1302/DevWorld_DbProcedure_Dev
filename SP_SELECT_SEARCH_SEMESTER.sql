USE [HELLO_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_SEARCH_SEMESTER]    Script Date: 15/06/2025 19:30:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 27. SP_SELECT_SEARCH_SEMESTER
ALTER PROCEDURE [dbo].[SP_SELECT_SEARCH_SEMESTER]
    @SemesterID VARCHAR(10) = NULL,
    @SemesterName NVARCHAR(100) = NULL,
	@StartDate Datetime = null,
	@EndDate Datetime = null
AS
BEGIN
    SELECT SemesterID, SemesterName, StartDate, EndDate
    FROM SEMESTER
    WHERE (@SemesterID IS NULL OR SemesterID LIKE '%' + @SemesterID + '%') 
        AND (@SemesterName IS NULL OR SemesterName LIKE '%' + @SemesterName + '%')
		AND (@StartDate is null AND @EndDate is null) OR(@StartDate > StartDate and @EndDate < EndDate)
END
