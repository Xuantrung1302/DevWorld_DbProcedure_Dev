ALTER PROCEDURE [dbo].[SP_SELECT_COURSE_DETAIL]
    @CourseID UNIQUEIDENTIFIER = NULL
AS
BEGIN
    SELECT DISTINCT
        sub.SubjectName,
        s.SemesterName,
        sub.TuitionFee
    FROM Course c
    INNER JOIN SEMESTER s ON c.course_id = s.course_id 
    INNER JOIN SUBJECT sub ON s.SemesterID = sub.SemesterID 
    WHERE
        ISNULL(c.delete_flg, 0) = 0
        AND ISNULL(s.DELETE_FLG, 0) = 0
        AND ISNULL(sub.DELETE_FLG, 0) = 0 
        AND (@CourseID IS NULL OR c.course_id = @CourseID)
    ORDER BY s.SemesterName, sub.SubjectName
END

----exec SP_SELECT_COURSE_DETAIL '39AEB1E8-C0C2-4044-9142-8C3908F9DC26'

--select * from Course
