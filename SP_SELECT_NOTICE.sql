
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_NOTICE]    Script Date: 2025/04/23 8:46:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyễn Xuân Trung>
-- Create date: <2025-04-22>
-- Description:	<Lấy ra nội dung thông báo>
-- =============================================
ALTER PROCEDURE [dbo].[SP_SELECT_NOTICE]
	
AS
BEGIN
	--SET NOCOUNT ON;
	SELECT N.NewsID, N.Title, N.Content, N.PostDate, N.PostedBy, E.FullName
    FROM NEWSBOARD N
	INNER JOIN ACCOUNT A ON A.Username = N.PostedBy
    INNER JOIN EMPLOYEE E ON E.Username = A.Username;

END

