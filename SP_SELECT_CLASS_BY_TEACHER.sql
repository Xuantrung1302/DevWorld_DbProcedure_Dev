SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 07/03/2025
-- Description:	Get class session by teacher
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[SP_SELECT_CLASS_BY_TEACHER]
(
	@TeacherID VARCHAR(10)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT
		@TeacherID AS TeacherID,
		C.ClassID,
		C.ClassName,
		S.SubjectID,
		S.SubjectName,
		C.DaysOfWeek,
		C.Room,
		C.StudentCount,
		SE.SemesterName,
		C.StartTime,
		C.EndTime
	FROM CLASS C
	JOIN SUBJECT S ON C.SubjectID = C.SubjectID
	JOIN SEMESTER SE ON S.SemesterID = SE.SemesterID
	WHERE TeacherID = @TeacherID
END
GO
