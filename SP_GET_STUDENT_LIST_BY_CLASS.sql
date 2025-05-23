USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_EMPLOYEE]    Script Date: 08/02/2025 14:06:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Description:	<Danh sách Học sinh của lớp>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GET_STUDENT_LIST_BY_CLASS]
	 @maLop varchar(9)
AS
BEGIN
		SELECT hv.MaHV, hv.TenHV, hv.GioiTinhHV
		FROM HOCVIEN hv 
		join BANGDIEM bd on bd.MaHV = hv.MaHV
		join LOPHOC lh on lh.MaLop = bd.MaLop
		WHERE lh.MaLop LIKE '%' + @maLop +'%'
END


