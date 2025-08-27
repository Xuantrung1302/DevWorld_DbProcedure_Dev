CREATE OR ALTER PROCEDURE [dbo].[sp_InsertCourseFromJson]
    @CourseCode VARCHAR(20),
    @CourseName NVARCHAR(100),
    @Semesters NVARCHAR(MAX)  -- JSON chứa danh sách học kỳ + môn học
AS
BEGIN
    --SET NOCOUNT ON;

    DECLARE @CourseID UNIQUEIDENTIFIER = NEWID();

    -- 1. Insert Course
    INSERT INTO Course (course_id, course_code, course_name, is_active, created_at, updated_at, delete_flg)
    VALUES (@CourseID, @CourseCode, @CourseName, 1, GETDATE(), GETDATE(), 0);

    -- 2. Duyệt JSON Học kỳ
    DECLARE @SemesterID VARCHAR(10);
    DECLARE @SemesterName NVARCHAR(100);
    DECLARE @StartDate DATETIME;
    DECLARE @EndDate DATETIME;

    DECLARE curSemesters CURSOR FOR
    SELECT JSON_VALUE(value, '$.SemesterName')
    FROM OPENJSON(@Semesters);

    OPEN curSemesters;
    FETCH NEXT FROM curSemesters INTO @SemesterName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @SemesterID = 'SM' + RIGHT('000' + CAST(ABS(CHECKSUM(NEWID())) % 999 AS VARCHAR(3)), 3);

        -- Xác định StartDate / EndDate theo kỳ
        IF @SemesterName = N'Học kỳ 1'
        BEGIN
            SET @StartDate = '2025-01-01';
            SET @EndDate   = '2025-06-30';
        END
        ELSE IF @SemesterName = N'Học kỳ 2'
        BEGIN
            SET @StartDate = '2025-07-01';
            SET @EndDate   = '2025-12-31';
        END
        ELSE
        BEGIN
            SET @StartDate = GETDATE();
            SET @EndDate   = DATEADD(MONTH, 3, GETDATE());
        END

        INSERT INTO Semester (SemesterID, SemesterName, StartDate, EndDate, DELETE_FLG, course_id)
        VALUES (@SemesterID, @SemesterName, @StartDate, @EndDate, 0, @CourseID);

        -- Thêm môn học cho Semester này
        INSERT INTO Subject (SubjectID, SubjectName, SemesterID, TuitionFee, DELETE_FLG, created_date, status)
        SELECT 
            'SB' + RIGHT('000' + CAST(ABS(CHECKSUM(NEWID())) % 9999 AS VARCHAR(4)), 4),
            JSON_VALUE(value, '$.SubjectName'),
            @SemesterID,
            CAST(JSON_VALUE(value, '$.TuitionFee') AS DECIMAL(12,2)),
            0,
            GETDATE(),
            1
        FROM OPENJSON(@Semesters)
        WITH (
            SemesterName NVARCHAR(100) '$.SemesterName',
            Subjects NVARCHAR(MAX) AS JSON
        ) s
        CROSS APPLY OPENJSON(s.Subjects)
        WHERE s.SemesterName = @SemesterName;

        FETCH NEXT FROM curSemesters INTO @SemesterName;
    END;

    CLOSE curSemesters;
    DEALLOCATE curSemesters;
END;
GO





--DECLARE @json NVARCHAR(MAX) = N'
--[
--  {
--    "SemesterName": "Học kỳ 1",
--    "Subjects": [
--      { "SubjectName": "Nhập môn CNTT", "TuitionFee": 100 },
--      { "SubjectName": "Tin học văn phòng", "TuitionFee": 100 }
--    ]
--  },
--  {
--    "SemesterName": "Học kỳ 2",
--    "Subjects": [
--      { "SubjectName": "Lập trình Java", "TuitionFee": 200 },
--      { "SubjectName": "Lập trình C#", "TuitionFee": 200 }
--    ]
--  }
--]';

--EXEC sp_InsertCourseFromJson
--    @CourseCode = 'DEV-FULL-2025',
--    @CourseName = N'Chương trình Lập trình viên quốc tế',
--    @Semesters = @json;


--select * from Course
--go
--select * from SEMESTER
--go
--select * from SUBJECT

-- Khởi tạo biến course_id
--DECLARE @course_id Uniqueidentifier = '06D0F01C-E092-451C-8EEB-AA075F2A8296';

---- Xóa các bản ghi trong bảng subject liên quan đến course_id
--DELETE FROM subject 
--WHERE SemesterID IN (
--    SELECT SemesterID 
--    FROM semester 
--    WHERE course_id = @course_id
--);

---- Xóa các bản ghi trong bảng semester liên quan đến course_id
--DELETE FROM semester 
--WHERE course_id = @course_id

---- Xóa bản ghi trong bảng course
--DELETE FROM course 
--WHERE course_id = @course_id
--go 
--select * from Course


--select * from class
--where course_id = '46CF1819-9F12-4E63-9B92-83F58B911B10'

--select * from CLASS_SCHEDULE
--where ClassID = 'B2AD3FE6-60FB-41D8-9641-8838D19C27E7'

--DELETE FROM SUBJECT
--WHERE SemesterID = 'SM981';

--select * from CLASS_ENROLLMENT
--where ClassID = 'B2AD3FE6-60FB-41D8-9641-8838D19C27E7'

--delete from Course
--where course_id = '46CF1819-9F12-4E63-9B92-83F58B911B10'

--select * from SEMESTER
--where course_id = '46CF1819-9F12-4E63-9B92-83F58B911B10'
--SM709
--SM981

--selec







