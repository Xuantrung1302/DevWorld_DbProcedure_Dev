USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_CENTER_INFORMATION]    Script Date: 2025/01/15 9:44:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<PHẠM QUANG HUY>
-- Create date: <2024-10-08>
-- Description:	<Lấy ra thông tin về trung tâm dạy lập trình>
-- =============================================
ALTER PROCEDURE [dbo].[SP_SELECT_CENTER_INFORMATION]

AS
BEGIN
	SELECT *
	FROM CHITIETTRUNGTAM
END
