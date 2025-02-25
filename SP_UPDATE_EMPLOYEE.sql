USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_EMPLOYEE]    Script Date: 2025/01/15 9:46:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Description:	<Sửa thông tin nhân viên: cho cả 2 TH: admin sửa và nhân viên tự sửa>
-- =============================================

/*
	[2024-10-09] Huy: 
*/
ALTER PROCEDURE [dbo].[SP_UPDATE_EMPLOYEE]
(
	@MaNV VARCHAR(6),
	@TenNV NVARCHAR(30),
	@SdtNV VARCHAR(12),
	@EmailNV VARCHAR(50),
	@MaLoaiNV VARCHAR(5),
	@TenDangNhap VARCHAR(20) = null,
	@MatKhau VARCHAR(20) = null
)
AS
BEGIN
	BEGIN TRANSACTION;

	-- Kiểm tra nếu @TenDangNhap và @MatKhau không phải là NULL thì mới cập nhật bảng TaiKhoan
	IF @TenDangNhap IS NOT NULL OR @MatKhau IS NOT NULL
	BEGIN
		UPDATE TaiKhoan
		SET MatKhau = @MatKhau
		WHERE TenDangNhap = @TenDangNhap;
	END

	-- Cập nhật dữ liệu trong bảng NhanVien
	UPDATE NhanVien
	SET TenNV = @TenNV, 
		SdtNV = @SdtNV, 
		EmailNV = @EmailNV, 
		MaLoaiNV = @MaLoaiNV
	WHERE MaNV = @MaNV;

	-- Nếu có lỗi xảy ra, rollback
	IF @@ERROR <> 0
		ROLLBACK;
	ELSE
		COMMIT;
END;



