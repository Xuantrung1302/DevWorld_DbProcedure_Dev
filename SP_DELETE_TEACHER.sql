USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_TEACHER]    Script Date: 2025/01/15 9:42:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyen Xun Trung>
-- Create date: <2024-10-05>
-- Description:	<Xóa thông tin giảng viên>
-- =============================================
ALTER PROCEDURE [dbo].[SP_DELETE_TEACHER]
(
	@MaGV VARCHAR(6),
	@TenDangNhap VARCHAR(20)
)
AS
BEGIN
	BEGIN TRANSACTION;

	-- Xóa dữ liệu từ bảng TaiKhoan
	DELETE FROM TaiKhoan
	WHERE TenDangNhap = @TenDangNhap;

	-- Xóa dữ liệu từ bảng NhanVien
	DELETE FROM GIANGVIEN
	WHERE MaGV = @MaGV;

	-- Nếu có lỗi xảy ra, rollback
	IF @@ERROR <> 0
		ROLLBACK;
	ELSE
		COMMIT;

END
