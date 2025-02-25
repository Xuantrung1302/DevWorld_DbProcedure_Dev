USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_CENTER_INFORMATION]    Script Date: 2025/01/15 9:45:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Description:	<Cập nhật thông tin của trung tâm>
-- =============================================
ALTER PROCEDURE [dbo].[SP_UPDATE_CENTER_INFORMATION] 
(
	@TenTT NVARCHAR(30),
	@DiaChiTT NVARCHAR(50),
	@SdtTT VARCHAR(12),
	@Website VARCHAR(50),
	@EmailTT VARCHAR(50)
)
AS
BEGIN
	UPDATE CHITIETTRUNGTAM
	SET [TenTT] = @TenTT,
		[DiaChiTT] = @DiaChiTT,
		[SdtTT] = @SdtTT,
		[Website] = @Website,
		[EmailTT] = @EmailTT
END
