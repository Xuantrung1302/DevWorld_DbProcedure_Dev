ALTER PROCEDURE [dbo].[SP_GET_STUDENT_FOR_ADD_CLASS]
    @ClassID UNIQUEIDENTIFIER
AS
BEGIN
    -- Lấy course_id của lớp hiện tại
    DECLARE @CourseID UNIQUEIDENTIFIER;
    SELECT @CourseID = course_id 
    FROM CLASS 
    WHERE ClassID = @ClassID;

    SELECT 
        S.StudentID, 
        S.FullName
    FROM STUDENT S
    WHERE 
        -- 1. Học viên chưa có trong lớp này
        S.StudentID NOT IN (
            SELECT CE.StudentID
            FROM CLASS_ENROLLMENT CE
            WHERE CE.ClassID = @ClassID
        )
        -- 2. Không bị trùng lịch học
        AND NOT EXISTS (
            SELECT 1
            FROM CLASS_ENROLLMENT CE
            INNER JOIN CLASS_SCHEDULE CS_EXIST 
                ON CE.ClassID = CS_EXIST.ClassID
            INNER JOIN CLASS_SCHEDULE CS_NEW
                ON CS_NEW.ClassID = @ClassID
            WHERE CE.StudentID = S.StudentID
              AND CS_EXIST.DayOfWeek = CS_NEW.DayOfWeek
              AND (
                    CS_EXIST.StartTime < CS_NEW.EndTime 
                    AND CS_EXIST.EndTime > CS_NEW.StartTime
                  )
        )
        -- 3. Không thuộc lớp nào khác của cùng khóa học
        AND NOT EXISTS (
            SELECT 1
            FROM CLASS_ENROLLMENT CE
            INNER JOIN CLASS C ON CE.ClassID = C.ClassID
            WHERE CE.StudentID = S.StudentID
              AND C.course_id = @CourseID
        )
    ORDER BY S.FullName;
END
GO
