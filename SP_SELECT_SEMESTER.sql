USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_SEMESTER]
    @SemesterID VARCHAR(10) = NULL,
    @SemesterName NVARCHAR(100) = NULL

AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        SEM.SemesterID, 
        SEM.SemesterName, 
        SEM.StartDate, 
        SEM.EndDate
    FROM SEMESTER SEM
    WHERE (SEM.DELETE_FLG = 0)
        AND (@SemesterID IS NULL OR SEM.SemesterID LIKE '%' + @SemesterID + '%')
        AND (@SemesterName IS NULL OR SEM.SemesterName LIKE '%' + @SemesterName + '%')

END
