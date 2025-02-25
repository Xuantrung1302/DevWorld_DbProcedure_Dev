USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_ACCOUNT]    Script Date: 2025/01/15 9:43:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Description:	<Xuất thông tin tài khoản và tìm kiếm từ bảng TAIKHOAN>
-- =============================================
ALTER PROCEDURE [dbo].[SP_SELECT_ACCOUNT]
(
	@TenDangNhap VARCHAR(20) = NULL
)
AS
BEGIN
	SELECT TenDangNhap, MatKhau
	FROM TAIKHOAN
	WHERE (@TenDangNhap IS NULL OR TenDangNhap LIKE '%' + @TenDangNhap + '%')
END
