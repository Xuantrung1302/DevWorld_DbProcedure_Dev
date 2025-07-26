USE [DEV_ACADEMY]
GO

ALTER PROCEDURE [SP_GET_CLASS_SCHEDULE_BY_USER]
    @StudentID VARCHAR(10) = NULL,
    @TeacherID VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        cs.Class_ScheID,
        cs.ClassID,
        cs.ClassName,
        cs.SubjectID,
        sj.SubjectName,
        cs.DayOfWeek,
        cs.StartTime,
        cs.EndTime,
        sm.SemesterID,
        sm.SemesterName,
        cr.course_id AS CourseID,
        cr.course_code,
        cr.course_name,
        t.FullName AS TeacherName
    FROM CLASS_SCHEDULE cs
    INNER JOIN CLASS c ON cs.ClassID = c.ClassID
    INNER JOIN SUBJECT sj ON cs.SubjectID = sj.SubjectID
    INNER JOIN SEMESTER sm ON sj.SemesterID = sm.SemesterID
    INNER JOIN COURSE cr ON sm.course_id = cr.course_id
    INNER JOIN TEACHER t ON c.TeacherID = t.TeacherID
    LEFT JOIN CLASS_ENROLLMENT ce ON c.ClassID = ce.ClassID
    WHERE 
        (
            @StudentID IS NULL OR ce.StudentID = @StudentID
        )
        AND (
            @TeacherID IS NULL OR c.TeacherID = @TeacherID
        )
    ORDER BY cs.StartTime
END
GO
