USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CLASS_SCORE_ID]    Script Date: 2025/04/22 10:29:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyen Xuan Trung>
-- Create date: <2024-10-04>
-- Description:	<Lấy điểm của từng lớp>
-- =============================================
-- 2025.04.22 Trung => issue: fix ten diem trung bình 
ALTER PROCEDURE [dbo].[SP_GET_CLASS_SCORE_ID]
(
	@maLop varchar(9)
)
AS
BEGIN
	SELECT H.MaHV, H.TenHV, B.DiemLyThuyet, B.DiemThucHanh, B.DiemDuAn, B.DiemCuoiKy, CAST((B.DiemCuoiKy + B.DiemDuAn + B.DiemLyThuyet + B.DiemThucHanh) AS FLOAT) / 4 as DiemTrungBinh --2025.04.22 Trung Edit
	FROM HOCVIEN H 
	INNER JOIN BANGDIEM B on H.MaHV = B.MaHV
	INNER JOIN LOPHOC L on B.MaLop = L.MaLop
	WHERE L.MaLop = @maLop 
END