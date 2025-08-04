CREATE OR ALTER PROCEDURE SP_INSERT_ATTENDANCE_RECORD
(
    @json NVARCHAR(MAX)
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        DECLARE @doc NVARCHAR(MAX) = @json;
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

        -- Đánh dấu buổi học đã diễn ra
        UPDATE CLASS_SCHEDULE
        SET Status = 1
        WHERE Class_ScheID = @ClassScheduleID;

        -- Chỉ cộng giờ dạy nếu chưa có bản ghi Payroll cho buổi này
        IF NOT EXISTS (
            SELECT 1
            FROM Payroll
            WHERE ClassScheduleID = @ClassScheduleID
            AND TeacherID = @RecordedBy
        )
        BEGIN
            DECLARE @teachingDate DATE;

            SELECT @teachingDate = CAST(StartTime AS DATE)
            FROM CLASS_SCHEDULE
            WHERE Class_ScheID = @ClassScheduleID;

            INSERT INTO Payroll (PayrollID, TeacherID, TeachingHours, RecordDate, ClassScheduleID)
            VALUES (NEWID(), @RecordedBy, 2.0, @teachingDate, @ClassScheduleID);
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;

        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT;
        SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY();
        RAISERROR (@ErrMsg, @ErrSeverity, 1);
    END CATCH
END
