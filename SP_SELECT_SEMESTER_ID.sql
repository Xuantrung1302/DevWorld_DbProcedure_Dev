SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyễn Xuân Trung>
-- Create date: <20-4-2025>
-- Description:	<Lấy ra mã kỳ học có lớp học>
-- =============================================
alter PROCEDURE SP_SELECT_SEMESTER_ID

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT S.SemesterID as SemesterID, S.SemesterName as SemesterName, S.StartDate, S.EndDate
	FROM SEMESTER S
		INNER JOIN CLASS C ON C.SemesterID = S.SemesterID
END
GO
