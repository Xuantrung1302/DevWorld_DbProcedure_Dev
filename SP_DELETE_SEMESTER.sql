USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_DELETE_SEMESTER]
    @SemesterID VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Update DELETE_FLG in SEMESTER
        UPDATE SEMESTER
        SET DELETE_FLG = 1
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
--EXEC SP_DELETE_SEMESTER @SemesterID = 'SEM2025B';
--Select * from SEMESTER