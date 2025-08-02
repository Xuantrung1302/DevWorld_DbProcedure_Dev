USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_ATTENDANCE_RECORD]
    @CourseID UNIQUEIDENTIFIER = NULL,
	@ClassID UNIQUEIDENTIFIER = NULL,
    @SubjectID VARCHAR(10) = NULL

AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        A.AttendanceID,
        C.ClassName,
        S.SubjectName,
        Se.SemesterName,
        Co.course_name AS CourseName,
        St.FullName AS StudentName,
        St.StudentID,
        A.Status,
        A.RecordedTime,
        T.FullName AS TeacherName,
        A.Notes
    FROM ATTENDANCE_RECORD A
    INNER JOIN CLASS_SCHEDULE CS ON A.Class_ScheID = CS.Class_ScheID
    INNER JOIN CLASS C ON CS.ClassID = C.ClassID
    INNER JOIN SUBJECT S ON CS.SubjectID = S.SubjectID
    INNER JOIN SEMESTER Se ON S.SemesterID = Se.SemesterID
    INNER JOIN Course Co ON Se.course_id = Co.course_id
    INNER JOIN STUDENT St ON A.StudentID = St.StudentID
    INNER JOIN TEACHER T ON A.RecordedBy = T.TeacherID
    WHERE A.DELETE_FLG = 0
      AND (@CourseID IS NULL OR Co.course_id = @CourseID)
      AND (@SubjectID IS NULL OR S.SubjectID = @SubjectID)
      AND (@ClassID IS NULL OR C.ClassID = @ClassID)
    ORDER BY A.RecordedTime DESC;
END
GO


----class id: 0827C74E-6F30-4081-AED5-A884EBC258AD


----15:00-17:00
----select * from Course
----select * from 
----MH5778

----go
----select * from SEMESTER
----where course_id = 'A87B8BEC-C779-45E7-ADC6-B61F42294939'
----select * from SUBJECT
----where SemesterID = 'SEM302'

----select * from ATTENDANCE_RECORD

--select * from SUBJECT
--where SemesterID = 'SEM302'
--exec SP_SELECT_ATTENDANCE_RECORD 'A87B8BEC-C779-45E7-ADC6-B61F42294939', '0827C74E-6F30-4081-AED5-A884EBC258AD', 'MH5778'