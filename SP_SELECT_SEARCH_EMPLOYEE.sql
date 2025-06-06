USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_SEARCH_EMPLOYEE]    Script Date: 2025/01/15 9:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Description:	<Danh sách nhân viên trong bảng NHANVIEN>
-- =============================================
ALTER PROCEDURE [dbo].[SP_SELECT_SEARCH_EMPLOYEE]
	@MaNV VARCHAR(6) = NULL,
	@TenNV NVARCHAR(30) = NULL,
	@TenLoaiNV NVARCHAR(30) = NULL
AS
BEGIN
	SELECT MaNV, TenNV, SdtNV, EmailNV, L.TenLoaiNV, N.MaLoaiNV, T.TenDangNhap, T.MatKhau
	FROM NHANVIEN N
		JOIN LOAINV L 
		ON N.MaLoaiNV = L.MaLoaiNV
		JOIN TAIKHOAN T
		ON T.TenDangNhap = N.TenDangNhap
	WHERE (@MaNV IS NULL OR MaNV LIKE '%' + @MaNV + '%') 
		AND (@TenNV IS NULL OR TenNV LIKE '%' + @TenNV + '%') 
		AND (@TenLoaiNV IS NULL OR L.TenLoaiNV LIKE '%' + @TenLoaiNV + '%')
END
