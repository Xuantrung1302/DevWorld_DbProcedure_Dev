USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_CLASS]
    @ClassID UNIQUEIDENTIFIER = NULL,
    @SubjectID VARCHAR(10) = NULL
    --@SemesterStatus NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        C.ClassID,
        C.ClassName,
        C.StartTime,
        C.EndTime,
        C.Room,
        C.MaxSeats,
        C.DaysOfWeek,
		C.StudentCount,
        S.SubjectName,
        Sem.SemesterName,
        --Sem.Status AS SemesterStatus,
        T.FullName AS TeacherName
    FROM CLASS C
    INNER JOIN SUBJECT S ON C.SubjectID = S.SubjectID
    INNER JOIN SEMESTER Sem ON S.SemesterID = Sem.SemesterID
    INNER JOIN TEACHER T ON C.TeacherID = T.TeacherID
    WHERE 
        (@ClassID IS NULL OR C.ClassID = @ClassID)
        AND (@SubjectID IS NULL OR S.SubjectID = @SubjectID)
        --AND (@SemesterStatus IS NULL OR Sem.Status = @SemesterStatus)
    ORDER BY C.StartTime;
END
