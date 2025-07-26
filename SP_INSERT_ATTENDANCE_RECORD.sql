USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_INSERT_ATTENDANCE_RECORD]
    @json NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO ATTENDANCE_RECORD (
            AttendanceID,
            Class_ScheID,
            StudentID,
            Status,
            RecordedTime,
            RecordedBy,
            Notes,
            DELETE_FLG
        )
        SELECT
            NEWID(),
            CAST(data.Class_ScheID AS UNIQUEIDENTIFIER),
            data.StudentID,
            CAST(data.Status AS INT),
            CAST(data.RecordedTime AS DATETIME),
            data.RecordedBy,
            data.Notes,
            0
        FROM OPENJSON(@json)
        WITH (
            Class_ScheID UNIQUEIDENTIFIER,
            StudentID VARCHAR(10),
            Status INT,
            RecordedTime DATETIME,
            RecordedBy VARCHAR(10),
            Notes NVARCHAR(200)
        ) AS data;

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


