CREATE OR ALTER PROCEDURE SP_INSERT_ATTENDANCE_RECORD
(
    @json NVARCHAR(MAX)
)
AS
BEGIN
    DECLARE @doc NVARCHAR(MAX) = @json;

    -- Giải JSON thành bảng tạm
    DECLARE @ClassScheduleID UNIQUEIDENTIFIER, @RecordedBy VARCHAR(10);

    SELECT 
        @ClassScheduleID = JSON_VALUE(@doc, '$.ClassScheduleID'),
        @RecordedBy = JSON_VALUE(@doc, '$.RecordedBy');

    SELECT 
        StudentID = JSON_VALUE(value, '$.StudentID'),
        Status = CASE WHEN JSON_VALUE(value, '$.Status') = 'true' THEN 1 ELSE 0 END,
        Notes = JSON_VALUE(value, '$.Notes')
    INTO #TempAttendance
    FROM OPENJSON(@doc, '$.ChiTiet');

    MERGE ATTENDANCE_RECORD AS target
    USING #TempAttendance AS source
    ON target.Class_ScheID = @ClassScheduleID AND target.StudentID = source.StudentID
    WHEN MATCHED THEN
        UPDATE SET 
            Status = source.Status,
            Notes = source.Notes,
            RecordedTime = GETDATE(),
            RecordedBy = @RecordedBy,
            DELETE_FLG = 0
    WHEN NOT MATCHED THEN
        INSERT (AttendanceID, Class_ScheID, StudentID, Status, RecordedTime, RecordedBy, Notes, DELETE_FLG)
        VALUES (NEWID(), @ClassScheduleID, source.StudentID, source.Status, GETDATE(), @RecordedBy, source.Notes, 0);
END
