CREATE PROCEDURE GetAvailableRooms
    @ExamDateStart DATETIME,
    @ExamDateEnd DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT c.Room
    FROM dbo.CLASS c
    WHERE c.Room IS NOT NULL
      AND c.Room NOT IN (
            -- Kiểm tra phòng trùng với EXAM_SCHEDULE
            SELECT es.Room
            FROM dbo.EXAM_SCHEDULE es
            WHERE es.Room IS NOT NULL
              AND (
                    (@ExamDateStart < es.ExamDateEnd AND @ExamDateEnd > es.ExamDateStart)
                  )
        )
      AND c.Room NOT IN (
            -- Kiểm tra phòng trùng với CLASS
            SELECT cl.Room
            FROM dbo.CLASS cl
            WHERE cl.Room IS NOT NULL
              AND (
                    (@ExamDateStart < cl.EndTime AND @ExamDateEnd > cl.StartTime)
                  )
        );
END;


--select * from CLASS