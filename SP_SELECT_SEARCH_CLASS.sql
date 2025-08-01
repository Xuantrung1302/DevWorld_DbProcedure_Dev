USE [HELLO_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_SEARCH_CLASS]    Script Date: 18/06/2025 00:17:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 26. SP_SELECT_SEARCH_CLASS
ALTER PROCEDURE [dbo].[SP_SELECT_SEARCH_CLASS]
    @ClassID VARCHAR(10) = NULL,
    @ClassName NVARCHAR(100) = NULL,
    @SemesterID VARCHAR(10) = NULL,
    @StartDate DATETIME = NULL,
    @EndDate DATETIME = NULL,
    @IsStudy BIT = NULL
AS
BEGIN
    SELECT ClassID, ClassName
    FROM CLASS
    WHERE (@ClassID IS NULL OR ClassID LIKE '%' + @ClassID + '%')
        AND (@ClassName IS NULL OR ClassName LIKE '%' + @ClassName + '%')
        AND (@SemesterID IS NULL OR SemesterID = @SemesterID)
        AND (@IsStudy IS NULL OR IsStudy = @IsStudy)
        AND (@StartDate IS NULL OR EXISTS (SELECT 1 FROM SEMESTER S WHERE S.SemesterID = CLASS.SemesterID AND S.StartDate <= @StartDate))
        AND (@EndDate IS NULL OR EXISTS (SELECT 1 FROM SEMESTER S WHERE S.SemesterID = CLASS.SemesterID AND S.EndDate <= @EndDate));
END
