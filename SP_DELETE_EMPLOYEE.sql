USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_EMPLOYEE]    Script Date: 2025/01/15 9:41:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Description:	<Xóa thông tin nhân viên vào trong bảng NHANVIEN>
-- =============================================
ALTER PROCEDURE [dbo].[SP_DELETE_EMPLOYEE]
(
	@MaNV VARCHAR(6),
	@TenDangNhap VARCHAR(20)
)
AS
BEGIN
	BEGIN TRANSACTION;

	-- Xóa dữ liệu từ bảng TaiKhoan
	DELETE FROM TaiKhoan
	WHERE TenDangNhap = @TenDangNhap;

	-- Xóa dữ liệu từ bảng NhanVien
	DELETE FROM NhanVien
	WHERE MaNV = @MaNV;

	-- Nếu có lỗi xảy ra, rollback
	IF @@ERROR <> 0
		ROLLBACK;
	ELSE
		COMMIT;

END
