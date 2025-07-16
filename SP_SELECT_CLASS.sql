ALTER PROCEDURE [dbo].[SP_SELECT_CLASS]
    @CourseID UNIQUEIDENTIFIER = NULL,
    @ClassName VARCHAR(50) = NULL
AS
BEGIN
    SELECT
        C.ClassID,
        C.ClassName,
        C.StartTime,
        C.EndTime,
        C.Room,
        C.MaxSeats,
        C.DaysOfWeek,
        C.StudentCount,
        T.FullName AS TeacherName,
        Co.course_name
    FROM CLASS C
    INNER JOIN Course Co ON C.course_id = Co.course_id
    LEFT JOIN TEACHER T ON C.TeacherID = T.TeacherID
    WHERE
        (@CourseID IS NULL OR C.course_id = @CourseID)
        AND (@ClassName IS NULL OR C.ClassName LIKE '%' + @ClassName + '%')
    ORDER BY C.StartTime;
END;