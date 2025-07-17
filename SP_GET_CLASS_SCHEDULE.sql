USE [DEV_ACADEMY]
GO
ALTER PROCEDURE [SP_GET_CLASS_SCHEDULE]
    @CourseID UNIQUEIDENTIFIER,
    @ClassID UNIQUEIDENTIFIER
    --@SemesterID VARCHAR(10)
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
        --AND sm.SemesterID = @SemesterID
    ORDER BY cs.StartTime;
END
GO
--select * from CLASS_SCHEDULE

--exec SP_GET_CLASS_SCHEDULE 'A87B8BEC-C779-45E7-ADC6-B61F42294939', 'BEF65320-EF19-4386-96F2-E16BD572A946', 'HK00000001'

--select * from Course
--go
--select * from CLASS
--go
--select * from SEMESTER