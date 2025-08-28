CREATE OR ALTER PROCEDURE SP_GET_AVAILABLE_ROOMS_FOR_CLASS
    @CourseID UNIQUEIDENTIFIER,
    @StartTime TIME,
    @EndTime TIME,
    @DaysOfWeek VARCHAR(20) -- "2,4,6"
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DECLARE @SemesterStart DATE;

        -- Lấy ngày bắt đầu của Học kỳ 1 (của course hiện tại)
        SELECT TOP 1 @SemesterStart = s.StartDate
        FROM SEMESTER s
        WHERE s.course_id = @CourseID
          AND s.SemesterName = N'Học kỳ 1';

        -- Lấy danh sách phòng khả dụng
        SELECT r.RoomID, r.Room, r.MaxSeats
        FROM ROOM r
        WHERE r.Room NOT IN (
            SELECT DISTINCT c.Room
            FROM CLASS c
            JOIN COURSE co ON c.course_id = co.course_id
            JOIN SEMESTER s ON s.course_id = co.course_id
            WHERE 
                -- Cùng ngày bắt đầu kỳ
                s.StartDate = @SemesterStart
                -- Trùng ca học (chỉ so sánh giờ, phút)
                AND CAST(c.StartTime AS TIME) = @StartTime
                AND CAST(c.EndTime AS TIME)   = @EndTime
                -- Trùng ít nhất 1 thứ trong tuần
                AND EXISTS (
                    SELECT 1
                    FROM STRING_SPLIT(@DaysOfWeek, ',') d1
                    JOIN STRING_SPLIT(c.DaysOfWeek, ',') d2
                        ON LTRIM(RTRIM(d1.value)) = LTRIM(RTRIM(d2.value))
                )
        )
        ORDER BY r.Room;

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO


--exec SP_GET_AVAILABLE_ROOMS_FOR_CLASS '57b249e8-59ed-4b62-a235-1804638312ae', '08:00', '10:00', 