USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_COUNT_STUDENTS_SUM_OWNER_MONEY]    Script Date: 2025/01/15 9:39:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Description:	<Xuất tổng số học viên và tổng nợ của họ>
-- =============================================
ALTER PROCEDURE [dbo].[SP_COUNT_STUDENTS_SUM_OWNER_MONEY]

AS
BEGIN
	SELECT COUNT(H.MaHV) AS N'Tổng cộng', SUM(ConNo) AS 'Tổng nợ'
	FROM HOCVIEN H
	JOIN DANGKY D ON D.MaHV = H.MAHV
	JOIN KHOAHOC K ON K.MaKH = D.MaKH
	JOIN PHIEUGHIDANH P ON P.MaPhieu = D.MaPhieu
	WHERE P.ConNo > 0
END
