USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CLASS_ID]    Script Date: 1/18/2025 2:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Description:	<Danh sách lớp trong bảng LOPHOC>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GET_CLASS_ID]
(
	@maLop varchar(9) = null
)
AS
BEGIN
	SELECT MaLop, TenLop
	FROM LOPHOC 
	WHERE @maLop is null OR MaLop LIKE '%' + @maLop + '%'
END


