USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_UPDATE_SUBJECT]
    @SubjectID VARCHAR(10),
    @SubjectName NVARCHAR(100),
    @SemesterID VARCHAR(10),
    @TuitionFee DECIMAL(12,2)
AS
BEGIN
    --SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE SUBJECT
        SET 
            SubjectName = @SubjectName,
            SemesterID = @SemesterID,
            TuitionFee = @TuitionFee
        WHERE SubjectID = @SubjectID AND (DELETE_FLG IS NULL OR DELETE_FLG = 0);

        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK;
            RAISERROR('Subject not found or already deleted.', 16, 1);
            RETURN 0;
        END

        COMMIT TRANSACTION;
        RETURN 1;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Err, 16, 1);
        RETURN 0;
    END CATCH
END
