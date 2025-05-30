USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_ACCOUNT]    Script Date: 2025/01/15 9:45:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Description:	<Sửa dữ liệu trong bảng Account(Đổi pass)>
-- =============================================
ALTER PROCEDURE [dbo].[SP_UPDATE_ACCOUNT]
(
	@TenDangNhap VARCHAR(20),
	@MatKhau VARCHAR(20)
)
AS
BEGIN
    UPDATE TAIKHOAN 
	SET MatKhau = @MatKhau
	WHERE TenDangNhap = @TenDangNhap
END
