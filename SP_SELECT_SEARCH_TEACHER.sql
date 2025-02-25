USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_SEARCH_TEACHER]    Script Date: 2025/01/15 9:45:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyen Xuan Trung>
-- Create date: <2024-09-30>
-- Description:	<Xuất danh sách và tìm kiếm Giảng viên>
-- =============================================
ALTER PROCEDURE [dbo].[SP_SELECT_SEARCH_TEACHER]
	@MaGV VARCHAR(6) = NULL,
	@TenGV NVARCHAR(30) = NULL,
	@GioiTinhGV NVARCHAR(3) = NULL
AS
BEGIN
	SELECT MaGV, TenGV, GioiTinhGV, SdtGV, EmailGV, T.TenDangNhap, T.MatKhau 
	FROM GIANGVIEN G
		JOIN TAIKHOAN T
		ON G.TenDangNhap = T.TenDangNhap
	WHERE (@MaGV IS NULL OR MaGV LIKE '%' + @MaGV + '%') 
		AND (@TenGV IS NULL OR TenGV LIKE '%' + @TenGV + '%') 
		AND (@GioiTinhGV IS NULL OR GioiTinhGV LIKE '%' + @GioiTinhGV + '%')
END


