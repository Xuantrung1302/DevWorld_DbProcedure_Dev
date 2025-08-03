SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE SP_SELECT_STUDENT_BY_SHCHEDULE 
	@ScheduleID UNIQUEIDENTIFIER
AS
BEGIN
	SET NOCOUNT ON;

	SELECT DISTINCT
		ST.FullName AS StudentName,
		ST.StudentID,
		ISNULL(A.Status, 0) AS Status,
		A.Notes
	FROM STUDENT ST
	JOIN CLASS_ENROLLMENT CE ON ST.StudentID = CE.StudentID
	JOIN CLASS_SCHEDULE CS ON CE.ClassID = CS.ClassID
	LEFT JOIN ATTENDANCE_RECORD A ON CS.Class_ScheID = A.Class_ScheID AND ST.StudentID = A.StudentID
	WHERE CS.Class_ScheID = @ScheduleID
END
