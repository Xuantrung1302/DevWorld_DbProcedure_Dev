USE [QLHVTTT1]
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
	SELECT b.MaBangTin, b.TieuDe as Title, b.NoiDung as Content, b.MaNV, b.NgayTao as CreateDate
	FROM BANGTIN b

END
