USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_ATTENDANCE_RECORD]
    @CourseID UNIQUEIDENTIFIER = NULL,
    @SemesterID VARCHAR(10) = NULL,
    @ClassID UNIQUEIDENTIFIER = NULL
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
      AND (@SemesterID IS NULL OR Se.SemesterID = @SemesterID)
      AND (@ClassID IS NULL OR C.ClassID = @ClassID)
    ORDER BY A.RecordedTime DESC;
END
GO
