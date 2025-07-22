USE [DEV_ACADEMY]
GO

ALTER PROCEDURE [dbo].[SP_GET_STUDENTS_BY_CLASS]
    @ClassID UNIQUEIDENTIFIER,
    @SubjectID VARCHAR(10)
AS
BEGIN

    DECLARE @TotalSessions INT;

    SELECT @TotalSessions = COUNT(*)
    FROM CLASS_SCHEDULE CS
    WHERE CS.ClassID = @ClassID AND CS.SubjectID = @SubjectID;

    SELECT 
        S.StudentID,
        S.FullName,
        S.Gender,
        S.PhoneNumber,
        S.Email,
        S.EnrollmentDate,

        ISNULL(AR.AttendanceCount, 0) AS AttendedSessions,

        CASE
            WHEN @TotalSessions = 0 THEN N'Chưa thi'
            WHEN ISNULL(AR.AttendanceCount, 0) * 1.0 / @TotalSessions < 0.8 THEN N'Cấm thi'
            ELSE N'Chưa thi'
        END AS Status

    FROM CLASS_ENROLLMENT CE
    INNER JOIN STUDENT S ON CE.StudentID = S.StudentID
    LEFT JOIN (
        SELECT AR.StudentID, COUNT(*) AS AttendanceCount
        FROM ATTENDANCE_RECORD AR
        INNER JOIN CLASS_SCHEDULE CS ON AR.Class_ScheID = CS.Class_ScheID
        WHERE CS.ClassID = @ClassID AND CS.SubjectID = @SubjectID
        GROUP BY AR.StudentID
    ) AR ON AR.StudentID = S.StudentID
    WHERE CE.ClassID = @ClassID
END
GO