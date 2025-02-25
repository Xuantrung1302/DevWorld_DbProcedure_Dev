USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_STUDENTS]    Script Date: 2025/01/15 9:46:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-10-03>
-- Description:	<Sửa học viên>
-- =============================================
ALTER PROCEDURE [dbo].[SP_UPDATE_STUDENTS]
(
	@MaHV VARCHAR(10),
	@TenHV NVARCHAR(30),
	@NgaySinh datetime,
	@GioiTinhHV NVARCHAR(3),
	@DiaChi NVARCHAR(30),
	@SdtHV VARCHAR(12),
	@EmailHV VARCHAR(50),
	@MaLoaiHV VARCHAR(5) = NULL,
	@NgayTiepNhan Datetime = NULL,
	@TenDangNhap VARCHAR(20) = NULL,
	@MatKhau VARCHAR(20) = NULL
)
AS
BEGIN
	IF @TenDangNhap iS null
	BEGIN
		UPDATE HOCVIEN 
		SET TenHV = @TenHV, 
			NgaySinh = NgaySinh, 
			GioiTinhHV = @GioiTinhHV, 
			DiaChi = @DiaChi, 
			SdtHV = @SdtHV, 
			EmailHV = @EmailHV
		WHERE MaHV= @MaHV
		RETURN
	END

	MERGE INTO TAIKHOAN AS target
	USING (SELECT @TenDangNhap as TenDangNhap, @MatKhau as MatKhau) source
	ON target.TenDangNhap = source.TenDangNhap
	WHEN MATCHED THEN 
		UPDATE SET target.MatKhau = source.MatKhau
	WHEN NOT MATCHED THEN
		INSERT (TenDangNhap,MatKhau)
		VALUES (source.TenDangNhap, source.MatKhau);

	UPDATE HOCVIEN 
		SET TenHV = @TenHV, 
			NgaySinh = NgaySinh, 
			GioiTinhHV = @GioiTinhHV, 
			DiaChi = @DiaChi, 
			SdtHV = @SdtHV, 
			EmailHV = @EmailHV,
			NgayTiepNhan = ISNULL(@NgayTiepNhan, NgayTiepNhan),
			MaLoaiHV = ISNULL(@MaLoaiHV, MaLoaiHV),
			TenDangNhap = ISNULL(@TenDangNhap, TenDangNhap)
		WHERE MaHV= @MaHV 
	
	--IF @MaLoaiHV = 'LHV01'
	--BEGIN
	--	UPDATE HOCVIEN 
	--	SET TenHV = @TenHV, NgaySinh = NgaySinh, GioiTinhHV = @GioiTinhHV, DiaChi = @DiaChi, SdtHV = @SdtHV, EmailHV = @EmailHV
	--	WHERE MaHV= @MaHV
	--	RETURN
	--END
END
