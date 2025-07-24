USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_COURSE_DETAIL]
    @CourseID UNIQUEIDENTIFIER = NULL
AS
BEGIN

    SELECT DISTINCT 
        c.course_code,
        c.course_name, 
        c.course_id, 
        sub.SubjectName, 
        s.SemesterName,
        sub.TuitionFee,
		CL.ClassName
    FROM Course c
    INNER JOIN SEMESTER s ON c.course_id = s.course_id 
    INNER JOIN SUBJECT sub ON s.SemesterID = sub.SemesterID 
	INNER JOIN CLASS CL ON C.course_id = c.course_id
    WHERE
        ISNULL(c.delete_flg, 0) = 0
        AND ISNULL(s.DELETE_FLG, 0) = 0
        AND ISNULL(sub.DELETE_FLG, 0) = 0 
        AND (@CourseID IS NULL OR c.course_id = @CourseID)
    ORDER BY c.course_name, s.SemesterName, sub.SubjectName
END
GO
--exec SP_SELECT_COURSE_DETAIL
