USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_SEARCH_STUDENTS]    Script Date: 2025/01/15 9:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_SELECT_SEARCH_STUDENTS]
(
	@MaHV VARCHAR(10) = NULL,
	@TenHV NVARCHAR(30) = NULL,
	@NgayTiepNhanStart DATETIME = NULL,
	@NgayTiepNhanEnd DATETIME = NULL,
	@GioiTinhHV NVARCHAR(3) = NULL,
	@MaLoaiHV VARCHAR(5) = NULL
)
AS
BEGIN
	SELECT 
		MaHV, 
		TenHV,
		NgaySinh, 
		GioiTinhHV,  
		SdtHV, 
		DiaChi, 
		NgayTiepNhan, 
		EmailHV,
		l.MaLoaiHV,
		t.TenDangNhap,
		t.MatKhau
	FROM HOCVIEN h
		JOIN LOAIHV l
		ON h.MaLoaiHV = l.MaLoaiHV
		Left JOIN TAIKHOAN t
		ON t.TenDangNhap = h.TenDangNhap
	WHERE (@MaHV IS NULL OR MaHV LIKE '%' + @MaHV + '%') 
		AND (@TenHV IS NULL OR TenHV LIKE '%' + @TenHV + '%') 
		AND (
			@NgayTiepNhanStart IS NULL OR 
			@NgayTiepNhanEnd IS NULL OR 
			NgayTiepNhan BETWEEN @NgayTiepNhanStart AND  @NgayTiepNhanEnd)
		AND (@GioiTinhHV IS NULL OR GioiTinhHV LIKE '%' + @GioiTinhHV + '%')
		AND (@MaLoaiHV IS NULL OR h.MaLoaiHV LIKE '%' + @MaLoaiHV + '%') 
END
