USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_UPDATE_SEMESTER]
    @SemesterID VARCHAR(10),
    @SemesterName NVARCHAR(100),
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    --SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Update SEMESTER
        UPDATE SEMESTER
        SET SemesterName = @SemesterName,
            StartDate = @StartDate,
            EndDate = @EndDate

        WHERE SemesterID = @SemesterID AND (DELETE_FLG = 0);

        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK;
            RAISERROR('Semester not found or already deleted.', 16, 1);
            RETURN 0;
        END

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
--EXEC SP_UPDATE_SEMESTER 
--    @SemesterID = 'SEM2025A',
--    @SemesterName = N'Học kỳ mùa thu 2025',
--    @StartDate = '2025-09-01',
--    @EndDate = '2026-01-15',
--    @Status = N'Đang diễn ra';
