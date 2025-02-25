USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CLASS_SCORE_ID]    Script Date: 1/18/2025 2:50:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GET_CLASS_SCORE_ID]
(
	@maLop varchar(9)
)
AS
BEGIN
	SELECT H.MaHV, H.TenHV, B.DiemLyThuyet, B.DiemThucHanh, B.DiemDuAn, B.DiemCuoiKy, CAST((B.DiemCuoiKy + B.DiemDuAn + B.DiemLyThuyet + B.DiemThucHanh) AS FLOAT) / 4 as N'Điểm trung bình'
	FROM HOCVIEN H 
	INNER JOIN BANGDIEM B on H.MaHV = B.MaHV
	INNER JOIN LOPHOC L on B.MaLop = L.MaLop
	WHERE L.MaLop = @maLop 
END