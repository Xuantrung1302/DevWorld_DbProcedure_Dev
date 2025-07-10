USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_UPDATE_ATTENDANCE_RECORD]
    @AttendanceID UNIQUEIDENTIFIER,
    @Status NVARCHAR(20),
    @RecordedBy VARCHAR(10),
    @Notes NVARCHAR(200) = NULL
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE ATTENDANCE_RECORD
        SET Status = @Status,
            RecordedTime = GETDATE(),
            RecordedBy = @RecordedBy,
            Notes = @Notes
        WHERE AttendanceID = @AttendanceID AND DELETE_FLG = 0;

        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK;
            RAISERROR('Attendance record not found or already deleted.', 16, 1);
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
    END CATCH;
END
