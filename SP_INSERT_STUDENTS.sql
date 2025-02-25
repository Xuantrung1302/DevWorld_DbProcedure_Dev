USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_STUDENTS]    Script Date: 2025/01/15 9:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-10-03>
-- Description:	<Thêm học viên-chính thức: có tài khoản, tiềm năng: không có tài khoản>
-- =============================================
ALTER PROCEDURE [dbo].[SP_INSERT_STUDENTS]
(
	@MaHV VARCHAR(10),
	@TenHV NVARCHAR(30),
	@NgaySinh datetime,
	@GioiTinhHV NVARCHAR(3),
	@DiaChi NVARCHAR(30),
	@SdtHV VARCHAR(12),
	@EmailHV VARCHAR(50),
	@MaLoaiHV VARCHAR(5),
	@NgayTiepNhan Datetime,
	@TenDangNhap VARCHAR(20) = NULL,
	@MatKhau VARCHAR(20) = NULL
)
AS
BEGIN
	IF @MaLoaiHV = 'LHV00'
	BEGIN


		-- Thêm dữ liệu vào bảng NhanVien
		INSERT INTO HOCVIEN(MaHV, TenHV, NgaySinh, GioiTinhHV, DiaChi, SdtHV, EmailHV, MaLoaiHV, NgayTiepNhan, TenDangNhap)
		VALUES (@MaHV, @TenHV, @NgaySinh, @GioiTinhHV, @DiaChi, @SdtHV, @EmailHV, @MaLoaiHV, @NgayTiepNhan, NULL);
	END
	IF @MaLoaiHV = 'LHV01'
	BEGIN
	
		-- Thêm dữ liệu vào bảng TaiKhoan
		INSERT INTO TaiKhoan (TenDangNhap, MatKhau)
		VALUES (@TenDangNhap, @MatKhau);

		INSERT INTO HOCVIEN(MaHV, TenHV, NgaySinh, GioiTinhHV, DiaChi, SdtHV, EmailHV, MaLoaiHV, NgayTiepNhan, TenDangNhap)
		VALUES (@MaHV, @TenHV, @NgaySinh, @GioiTinhHV, @DiaChi, @SdtHV, @EmailHV, @MaLoaiHV, @NgayTiepNhan, @TenDangNhap);

	
	END

END
