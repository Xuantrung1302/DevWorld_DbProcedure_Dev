USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_SHOW_INFOR_OF_STUDENTS]    Script Date: 1/18/2025 2:50:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-11-11>
-- Description:	<Hiển thị điểm học viên theo mã Học viên>
-- =============================================
ALTER PROCEDURE [dbo].[SP_SHOW_INFOR_OF_STUDENTS]
(
	@maHv varchar(10)
)
AS
BEGIN
	Select L.MaLop, L.TenLop, K.TenKH, H.MaHV, H.TenHV, D.DiemLyThuyet, D.DiemThucHanh, D.DiemDuAn, D.DiemCuoiKy
	FROM BANGDIEM D
	INNER JOIN HOCVIEN H ON D.MaHV = H.MaHV
	INNER JOIN LOPHOC L ON D.MaLop = L.MaLop
	INNER JOIN KHOAHOC K ON L.MaKH = K.MaKH
	WHERE H.MaHV = @maHv
END