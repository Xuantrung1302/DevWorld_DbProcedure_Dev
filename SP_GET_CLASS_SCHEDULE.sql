USE [DEV_ACADEMY]
GO
ALTER PROCEDURE [SP_GET_CLASS_SCHEDULE]
    @CourseID UNIQUEIDENTIFIER,
    @ClassID UNIQUEIDENTIFIER,
    @SubjectID VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @SubjectID IS NOT NULL
    BEGIN
        SELECT TOP 1
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
            T.FullName
        FROM CLASS_SCHEDULE cs
        INNER JOIN CLASS c ON cs.ClassID = c.ClassID
        INNER JOIN SUBJECT sj ON cs.SubjectID = sj.SubjectID
        INNER JOIN SEMESTER sm ON sj.SemesterID = sm.SemesterID
        INNER JOIN Course cr ON sm.course_id = cr.course_id
        INNER JOIN TEACHER T ON T.TeacherID = C.TeacherID
        WHERE
            cr.course_id = @CourseID
            AND cs.ClassID = @ClassID
            AND cs.SubjectID = @SubjectID
        ORDER BY cs.StartTime DESC
    END
    ELSE
    BEGIN
        SELECT 
            cs.Class_ScheID,
            cs.ClassID,
            cs.ClassName,
            cs.SubjectID,
            sj.SubjectName,
            cs.DayOfWeek,
            cs.StartTime,
            cs.EndTime,
			c.Room,
            sm.SemesterID,
            sm.SemesterName,
            cr.course_id AS CourseID,
            cr.course_code,
            cr.course_name,
            T.FullName
        FROM CLASS_SCHEDULE cs
        INNER JOIN CLASS c ON cs.ClassID = c.ClassID
        INNER JOIN SUBJECT sj ON cs.SubjectID = sj.SubjectID
        INNER JOIN SEMESTER sm ON sj.SemesterID = sm.SemesterID
        INNER JOIN Course cr ON sm.course_id = cr.course_id
        INNER JOIN TEACHER T ON T.TeacherID = C.TeacherID
        WHERE
            cr.course_id = @CourseID
            AND cs.ClassID = @ClassID
        ORDER BY cs.StartTime
    END
END
GO

--exec SP_GET_CLASS_SCHEDULE '1d28aea2-8a38-4bde-b06d-c5c209e098d0', '3915a649-d8e2-4151-9ab8-508b6de3176f'