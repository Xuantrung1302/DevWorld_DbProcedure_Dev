USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_CLASS]    Script Date: 2025/01/15 9:45:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyen Xuan Trung>
-- Create date: <2024-10-04>
-- Description:	<SỬA THÔNG TIN lớp học>
-- =============================================
ALTER PROCEDURE [dbo].[SP_UPDATE_CLASS]
(
	@MaLop VARCHAR(9) ,
	@TenLop NVARCHAR(30),
	@NgayKt datetime,
	@TinhTrang BIT
)
AS
BEGIN
	UPDATE LOPHOC
	SET TenLop = @TenLop, NgayKt = @NgayKt, DangMo = @TinhTrang
	WHERE MaLop = @MaLop
END
