USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_ATTENDANCE_RECORD]
    @SemesterID VARCHAR(10) = NULL,
    @SubjectID VARCHAR(10) = NULL,
    @ClassID UNIQUEIDENTIFIER = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        A.AttendanceID,
        CS.ClassName,
        S.SubjectName,
        Se.SemesterName,
        St.FullName AS StudentName,
        A.Status,
        A.RecordedTime,
        T.FullName AS TeacherName,
        A.Notes
    FROM ATTENDANCE_RECORD A
    INNER JOIN CLASS_SCHEDULE CS ON A.Class_ScheID = CS.Class_ScheID
    INNER JOIN CLASS C ON CS.ClassID = C.ClassID
    INNER JOIN SUBJECT S ON C.SubjectID = S.SubjectID
    INNER JOIN SEMESTER Se ON S.SemesterID = Se.SemesterID
    INNER JOIN STUDENT St ON A.StudentID = St.StudentID
    INNER JOIN TEACHER T ON A.RecordedBy = T.TeacherID
    WHERE A.DELETE_FLG = 0
      AND (@SemesterID IS NULL OR S.SemesterID = @SemesterID)
      AND (@SubjectID IS NULL OR S.SubjectID = @SubjectID)
      AND (@ClassID IS NULL OR C.ClassID = @ClassID)
    ORDER BY A.RecordedTime DESC;
END
