USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_EMPLOYEE_TYPE]    Script Date: 2025/01/15 9:44:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Description:	<Xuất dữ liệu trong bảng LOAINV>
-- =============================================
ALTER PROCEDURE [dbo].[SP_SELECT_EMPLOYEE_TYPE]

AS
BEGIN
	SELECT * 
	FROM LOAINV
END
