USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_STUDENT_ID]    Script Date: 2025/01/15 9:42:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Description:	<Danh sách nhân viên trong bảng NHANVIEN>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GET_STUDENT_ID]
AS
BEGIN
	SELECT MaHV
	FROM HOCVIEN 
END
