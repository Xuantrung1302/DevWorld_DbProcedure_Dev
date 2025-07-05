USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_INSERT_ATTENDANCE_RECORD]
    @AttendanceID UNIQUEIDENTIFIER,
    @Class_ScheID UNIQUEIDENTIFIER,
    @StudentID VARCHAR(10),
    @Status NVARCHAR(20),
    @RecordedTime DATETIME,
    @RecordedBy VARCHAR(10),
    @Notes NVARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO ATTENDANCE_RECORD
            (AttendanceID, Class_ScheID, StudentID, Status, RecordedTime, RecordedBy, Notes, DELETE_FLG)
        VALUES
            (@AttendanceID, @Class_ScheID, @StudentID, @Status, @RecordedTime, @RecordedBy, @Notes, 0);

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

