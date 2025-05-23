USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_LIST_STUDENTS_OWN_MONEY]    Script Date: 2025/01/15 9:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Description:	<Xuất danh sách các học viên đang nợ học phí>
-- =============================================
ALTER PROCEDURE [dbo].[SP_SELECT_LIST_STUDENTS_OWN_MONEY]

AS
BEGIN
	SELECT H.MaHV, H.TenHV, GioiTinhHV, K.TenKH, P.ConNo
	FROM HOCVIEN H
	JOIN DANGKY D ON D.MaHV = H.MAHV
	JOIN KHOAHOC K ON K.MaKH = D.MaKH
	JOIN PHIEUGHIDANH P ON P.MaPhieu = D.MaPhieu
	WHERE P.ConNo > 0
END
