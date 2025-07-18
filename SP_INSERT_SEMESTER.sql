USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_INSERT_SEMESTER]
    @SemesterID VARCHAR(10),
    @SemesterName NVARCHAR(100),
    @StartDate DATETIME,
    @EndDate DATETIME,
	@CourseID UNIQUEIDENTIFIER
AS
BEGIN
    --SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO SEMESTER (SemesterID, SemesterName, StartDate, EndDate, DELETE_FLG, course_id)
        VALUES (@SemesterID, @SemesterName, @StartDate, @EndDate, 0, @CourseID);

        COMMIT TRANSACTION;
        RETURN 1; -- Success
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN 0; -- Failure
    END CATCH;
END
--EXEC SP_INSERT_SEMESTER 
--    @SemesterID = 'SEM2025B',
--    @SemesterName = N'Học kỳ mùa đông 2025',
--    @StartDate = '2025-12-01',
--    @EndDate = '2026-04-01'
