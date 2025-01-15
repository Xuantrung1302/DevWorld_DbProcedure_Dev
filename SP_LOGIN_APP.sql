USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_LOGIN_APP]    Script Date: 2025/01/15 9:43:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-10-04>
-- Description:	<Đăng nhập vào App>
-- =============================================
ALTER PROCEDURE [dbo].[SP_LOGIN_APP]
(
	@TenDangNhap VARCHAR(20),
	@MatKhau VARCHAR(20)

)
AS
BEGIN
	SELECT * 
	FROM TAIKHOAN
	WHERE TenDangNhap = @TenDangNhap
		AND MatKhau = @MatKhau
END
