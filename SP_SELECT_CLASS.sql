ALTER PROCEDURE [dbo].[SP_SELECT_CLASS]
    @ClassID UNIQUEIDENTIFIER = NULL,
    @SubjectID VARCHAR(10) = NULL,
	@SemesterID VARCHAR(10) = NULL
AS
BEGIN
    --SET NOCOUNT ON;

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
        T.FullName AS TeacherName
    FROM CLASS C
    INNER JOIN SUBJECT S ON C.SubjectID = S.SubjectID
    INNER JOIN SEMESTER Sem ON S.SemesterID = Sem.SemesterID
    LEFT JOIN TEACHER T ON C.TeacherID = T.TeacherID  -- Đổi INNER thành LEFT
    WHERE 
        (@ClassID IS NULL OR C.ClassID = @ClassID)
        AND (@SubjectID IS NULL OR C.SubjectID = @SubjectID)
		AND (@SemesterID IS NULL OR Sem.SemesterID = @SemesterID)
    ORDER BY C.StartTime;
END
