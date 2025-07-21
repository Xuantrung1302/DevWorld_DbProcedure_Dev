USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_SELECT_SUBJECT_BY_COURSE]
    @CourseID UNIQUEIDENTIFIER
AS
BEGIN
    --SET NOCOUNT ON;

    SELECT
        S.SubjectID,
        S.SubjectName
    FROM SUBJECT S
	inner join SEMESTER se on se.SemesterID = s.SemesterID
	inner join Course c on c.course_id = se.course_id
    WHERE c.course_id = @CourseID;
END
GO

--select * from Course
--go
--select * from SEMESTER
--go
--select * from SUBJECT