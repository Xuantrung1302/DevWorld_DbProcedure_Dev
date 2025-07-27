SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE SP_SELECT_CLASS_SCHEDULE_BY_TEACHER 
	@TeacherID VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT
		CO.course_id AS CourseID,
		CO.course_name AS CourseName,
		CL.ClassID AS ClassID,
		CL.ClassName AS ClassName,
		SU.SubjectID AS SubjectID,
		SU.SubjectName AS SubjectName,
		CLS.Class_ScheID AS ClassScheduleID,
		CLS.EndTime AS Date
	FROM CLASS CL
	JOIN Course CO ON CL.course_id = CO.course_id
	JOIN SEMESTER SE ON CO.course_id = SE.course_id
	JOIN SUBJECT SU ON SU.SemesterID = SE.SemesterID
	JOIN CLASS_SCHEDULE CLS ON CL.ClassID = CLS.ClassID AND CLS.SubjectID = SU.SubjectID
	WHERE TeacherID = @TeacherID
END
GO
