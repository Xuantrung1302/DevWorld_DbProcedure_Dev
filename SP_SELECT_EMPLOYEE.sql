USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_EMPLOYEE]    Script Date: 2025/01/15 9:44:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Description:	<Danh sách nhân viên trong bảng NHANVIEN>
-- =============================================
ALTER PROCEDURE [dbo].[SP_SELECT_EMPLOYEE]

AS
BEGIN
	SELECT MaNV, TenNV, SdtNV, EmailNV, L.TenLoaiNV 
	FROM NHANVIEN N
		JOIN LOAINV L 
		ON N.MaLoaiNV = L.MaLoaiNV
END
