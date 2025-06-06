USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CLASS_BY_ROLE]    Script Date: 08/02/2025 14:13:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GET_CLASS_BY_ROLE]
(
	@ma varchar(9) = null
)
AS
BEGIN
    IF @ma LIKE 'GV%'
	BEGIN
		SELECT lh.MaLop, lh.TenLop, lh.NgayBD, lh.NgayKT, lh.DangMo, lh.SiSo
		FROM GIANGVIEN gv 
		join GIANGDAY gd on gd.MaGV = gv.MaGV
		join LOPHOC lh on lh.MaLop = gd.MaLop
		WHERE gv.MaGV LIKE '%' + @ma +'%'
	END
	ELSE IF @ma LIKE 'HV%'
	BEGIN
		SELECT lh.MaLop, lh.TenLop
		FROM HOCVIEN hv 
		join BANGDIEM bd on bd.MaHV = hv.MaHV
		join LOPHOC lh on lh.MaLop = bd.MaLop
		WHERE hv.MaHV LIKE '%' + @ma +'%'
	END
END
