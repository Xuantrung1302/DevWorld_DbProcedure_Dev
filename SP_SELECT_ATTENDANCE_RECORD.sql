--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO

--ALTER PROCEDURE [dbo].[SP_SELECT_ATTENDANCE_RECORD]
--    @CourseID UNIQUEIDENTIFIER = NULL,
--	@ClassID UNIQUEIDENTIFIER = NULL,
--    @SubjectID VARCHAR(10) = NULL

--AS
--BEGIN
--    SET NOCOUNT ON;

--    SELECT DISTINCT ST.StudentID,
--        ST.FullName AS StudentName,
--        CS.Status AS IsLearned,
--        A.Class_ScheID,
--        A.AttendanceID,
--        A.Status,
--        A.Notes
--    FROM STUDENT ST
--    LEFT JOIN ATTENDANCE_RECORD A ON ST.StudentID = A.StudentID
--    JOIN CLASS_ENROLLMENT CL ON ST.StudentID  = CL.StudentID
--    INNER JOIN CLASS C ON CL.ClassID = C.ClassID
--    INNER JOIN CLASS_SCHEDULE CS ON C.ClassID = CS.ClassID
--    INNER JOIN SUBJECT S ON CS.SubjectID = S.SubjectID
--    INNER JOIN SEMESTER Se ON S.SemesterID = Se.SemesterID
--    INNER JOIN Course Co ON Se.course_id = Co.course_id
--    WHERE (@CourseID IS NULL OR Co.course_id = @CourseID)
--          AND (@SubjectID IS NULL OR S.SubjectID = @SubjectID)
--          AND (@ClassID IS NULL OR C.ClassID = @ClassID)
--    --ORDER BY A.RecordedTime DESC;
--END
--GO

ALTER PROCEDURE [dbo].[SP_SELECT_ATTENDANCE_RECORD]
    @CourseID UNIQUEIDENTIFIER = NULL,
    @ClassID UNIQUEIDENTIFIER = NULL,
    @SubjectID VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ST.StudentID,
        ST.FullName AS StudentName,
        CS.Class_ScheID,
        CS.Status AS IsLearned,
        A.AttendanceID,
        ISNULL(A.Status, 0) AS Status,
        A.Notes
    FROM CLASS_SCHEDULE CS
    INNER JOIN CLASS C ON CS.ClassID = C.ClassID
    INNER JOIN SUBJECT S ON CS.SubjectID = S.SubjectID
    INNER JOIN SEMESTER Se ON S.SemesterID = Se.SemesterID
    INNER JOIN COURSE Co ON Se.course_id = Co.course_id
    INNER JOIN CLASS_ENROLLMENT CE ON C.ClassID = CE.ClassID
    INNER JOIN STUDENT ST ON CE.StudentID = ST.StudentID

    OUTER APPLY (
        SELECT TOP 1 AR.AttendanceID, AR.Status, AR.Notes
        FROM ATTENDANCE_RECORD AR
        WHERE AR.Class_ScheID = CS.Class_ScheID AND AR.StudentID = ST.StudentID
    ) A

    WHERE
        (@CourseID IS NULL OR Co.course_id = @CourseID)
        AND (@SubjectID IS NULL OR S.SubjectID = @SubjectID)
        AND (@ClassID IS NULL OR C.ClassID = @ClassID)
END
