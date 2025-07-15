USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter PROCEDURE [dbo].[SP_SELECT_COURSE_DETAIL]
    @CourseID UNIQUEIDENTIFIER = NULL,
    @CourseName NVARCHAR(100) = NULL,
    @SemesterName NVARCHAR(100) = NULL,
    @SubjectName NVARCHAR(100) = NULL
AS
BEGIN
    --SET NOCOUNT ON;

    SELECT distinct
        c.course_id AS CourseID,
        c.course_name AS CourseName,
        c.course_code AS CourseCode,
        s.SemesterName,
        sub.SubjectName,
		--cl.ClassID,
		cl.ClassName,
        sub.TuitionFee AS Fee
    FROM Course c
    INNER JOIN SEMESTER s ON c.course_id = s.course_id
    INNER JOIN SUBJECT sub ON s.SemesterID = sub.SemesterID
	INNER JOIN CLASS cl ON cl.SubjectID = sub.SubjectID
    WHERE
        ISNULL(c.delete_flg, 0) = 0
        AND ISNULL(s.DELETE_FLG, 0) = 0
        AND ISNULL(sub.DELETE_FLG, 0) = 0
        AND (@CourseID IS NULL OR c.course_id = @CourseID)
        AND (@CourseName IS NULL OR c.course_name LIKE '%' + @CourseName + '%')
        AND (@SemesterName IS NULL OR s.SemesterName LIKE '%' + @SemesterName + '%')
        AND (@SubjectName IS NULL OR sub.SubjectName LIKE '%' + @SubjectName + '%')
    ORDER BY c.course_name, s.SemesterName, sub.SubjectName
END
--EXEC SP_SELECT_COURSE_DETAIL @CourseName = N'Fullstack';


--select * from CLASS
--where ClassID = 'D7FA6CED-E503-4B96-9A0D-54F608128F61'