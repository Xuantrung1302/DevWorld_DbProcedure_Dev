USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_UPDATE_ATTENDANCE_RECORD]
    @json NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        WITH DataToUpdate AS (
            SELECT
                CAST(data.AttendanceID AS UNIQUEIDENTIFIER) AS AttendanceID,
                CAST(data.Status AS INT) AS Status,
                CAST(data.RecordedTime AS DATETIME) AS RecordedTime,
                data.RecordedBy,
                data.Notes
            FROM OPENJSON(@json)
            WITH (
                AttendanceID UNIQUEIDENTIFIER,
                Status INT,
                RecordedTime DATETIME,
                RecordedBy VARCHAR(10),
                Notes NVARCHAR(200)
            ) AS data
        )
        UPDATE AR
        SET
            AR.Status = DTU.Status,
            AR.RecordedTime = DTU.RecordedTime,
            AR.RecordedBy = DTU.RecordedBy,
            AR.Notes = DTU.Notes
        FROM ATTENDANCE_RECORD AR
        JOIN DataToUpdate DTU ON AR.AttendanceID = DTU.AttendanceID
        WHERE AR.DELETE_FLG = 0;

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
