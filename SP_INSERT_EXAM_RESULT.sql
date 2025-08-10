ALTER PROCEDURE [dbo].[SP_INSERT_EXAM_RESULT]
    @json NVARCHAR(MAX)
AS
BEGIN
    SET XACT_ABORT ON;

    DECLARE @PassScore DECIMAL(5,2) = 5.00; -- Ngưỡng đạt

    BEGIN TRY
        BEGIN TRANSACTION;

        ----------------------------------------------------------------
        -- 1) Đọc mảng JSON thành bảng tạm @SourceWithExam
        ----------------------------------------------------------------
        DECLARE @SourceWithExam TABLE
        (
            StudentID   VARCHAR(10),
            ClassID     UNIQUEIDENTIFIER,
            SubjectID   VARCHAR(10),
            Score       DECIMAL(5,2) NULL,
            EnteredBy   VARCHAR(10),
            GradingDate DATETIME,
            ExamID      UNIQUEIDENTIFIER NULL
        );

        INSERT INTO @SourceWithExam (StudentID, ClassID, SubjectID, Score, EnteredBy, GradingDate, ExamID)
        SELECT  
            s.StudentID,
            s.ClassID,
            s.SubjectID,
            TRY_CAST(s.Score AS DECIMAL(5,2)),
            s.EnteredBy,
            ISNULL(TRY_CAST(s.GradingDate AS DATETIME), GETDATE()),
            e.ExamID
        FROM OPENJSON(@json)
        WITH (
            StudentID  VARCHAR(10),
            ClassID    UNIQUEIDENTIFIER,
            SubjectID  VARCHAR(10),
            Score      NVARCHAR(50),
            EnteredBy  VARCHAR(10),
            GradingDate NVARCHAR(30)
        ) s
        OUTER APPLY (
            SELECT TOP 1 ExamID
            FROM EXAM_SCHEDULE
            WHERE ClassID = s.ClassID
              AND SubjectID = s.SubjectID
            ORDER BY CreatedDate DESC, ExamDateStart DESC
        ) e;

        ----------------------------------------------------------------
        -- 2) Kiểm tra các dòng không có ExamID để báo lỗi
        ----------------------------------------------------------------
        IF EXISTS (
            SELECT 1 FROM @SourceWithExam WHERE ExamID IS NULL
        )
        BEGIN
            RAISERROR(N'Một số bản ghi không tìm thấy ExamID cho ClassID + SubjectID.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        ----------------------------------------------------------------
        -- 3) MERGE vào EXAM_RESULT
        ----------------------------------------------------------------
        MERGE INTO EXAM_RESULT AS target
        USING (
            SELECT
                ExamID,
                StudentID,
                Score,
                CASE 
                    WHEN Score IS NULL THEN N'Chưa chấm'
                    WHEN Score >= @PassScore THEN N'Đạt'
                    ELSE N'Không đạt'
                END AS Status,
                EnteredBy,
                GradingDate
            FROM @SourceWithExam
        ) AS source
        ON target.ExamID = source.ExamID
           AND target.StudentID = source.StudentID
           AND ISNULL(target.DELETE_FLG, 0) = 0
        WHEN MATCHED THEN
            UPDATE SET
                Score = source.Score,
                Status = source.Status,
                EnteredBy = source.EnteredBy,
                GradingDate = source.GradingDate
        WHEN NOT MATCHED THEN
            INSERT (ResultID, ExamID, StudentID, Score, Status, EnteredBy, GradingDate, DELETE_FLG)
            VALUES (NEWID(), source.ExamID, source.StudentID, source.Score, source.Status, source.EnteredBy, source.GradingDate, 0);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Lỗi khi lưu điểm: %s',16,1,@ErrMsg);
    END CATCH
END



--exec SP_INSERT_EXAM_RESULT '[{"StudentID":"HV031","ClassID":"e595377d-6732-4b44-8cbb-163a5769f8ae","SubjectID":"MH1534","Score":5.0,"EnteredBy":"NV001"},{"StudentID":"HV109","ClassID":"e595377d-6732-4b44-8cbb-163a5769f8ae","SubjectID":"MH1534","Score":6.0,"EnteredBy":"NV001"},{"StudentID":"HV135","ClassID":"e595377d-6732-4b44-8cbb-163a5769f8ae","SubjectID":"MH1534","Score":7.0,"EnteredBy":"NV001"},{"StudentID":"HV250","ClassID":"e595377d-6732-4b44-8cbb-163a5769f8ae","SubjectID":"MH1534","Score":5.0,"EnteredBy":"NV001"},{"StudentID":"HV291","ClassID":"e595377d-6732-4b44-8cbb-163a5769f8ae","SubjectID":"MH1534","Score":4.0,"EnteredBy":"NV001"},{"StudentID":"HV368","ClassID":"e595377d-6732-4b44-8cbb-163a5769f8ae","SubjectID":"MH1534","Score":7.0,"EnteredBy":"NV001"},{"StudentID":"HV410","ClassID":"e595377d-6732-4b44-8cbb-163a5769f8ae","SubjectID":"MH1534","Score":7.0,"EnteredBy":"NV001"},{"StudentID":"HV420","ClassID":"e595377d-6732-4b44-8cbb-163a5769f8ae","SubjectID":"MH1534","Score":8.0,"EnteredBy":"NV001"},{"StudentID":"HV423","ClassID":"e595377d-6732-4b44-8cbb-163a5769f8ae","SubjectID":"MH1534","Score":6.0,"EnteredBy":"NV001"},{"StudentID":"HV439","ClassID":"e595377d-6732-4b44-8cbb-163a5769f8ae","SubjectID":"MH1534","Score":6.0,"EnteredBy":"NV001"},{"StudentID":"HV453","ClassID":"e595377d-6732-4b44-8cbb-163a5769f8ae","SubjectID":"MH1534","Score":5.0,"EnteredBy":"NV001"}]
--'

--select * from EXAM_RESULT