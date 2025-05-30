USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_LOGIN]    Script Date: 2025/01/15 9:43:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-10-04>
-- Description:	<Tìm và cho ra đúng tên tài khoản, mật khẩu và tên đầy đủ của người dùng đăng nhập>

/*
	[2024-10-09] Trung: lấy ra tên đầy đủ của người đăng nhập
*/
-- =============================================
ALTER PROCEDURE [dbo].[SP_LOGIN]
(
	@TenDangNhap VARCHAR(20),
	@MatKhau VARCHAR(20)
)
AS
BEGIN
	SELECT N.MaNV, H.MaHV, G.MaGV,T.TenDangNhap, MatKhau, n.MaLoaiNV, h.MaLoaiHV, N.TenNV, H.TenHV, G.TenGV
	FROM TAIKHOAN T
		LEFT JOIN NHANVIEN N 
		ON N.TenDangNhap = T.TenDangNhap
		LEFT JOIN HOCVIEN H
		ON H.TenDangNhap = T.TenDangNhap
		LEFT JOIN GIANGVIEN G
		ON G.TenDangNhap = T.TenDangNhap
		
	WHERE T.TenDangNhap = @TenDangNhap AND MatKhau = @MatKhau
END




