USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_CLASS]    Script Date: 2025/01/15 9:42:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyen Xuan Trung>
-- Create date: <2024-10-04>
-- Description:	<Thêm lớp học>
-- =============================================
ALTER PROCEDURE [dbo].[SP_INSERT_CLASS]
(
	@MaLop VARCHAR(9) ,
	@TenLop NVARCHAR(30),
	@NgayBd datetime,
	@NgayKt datetime,
	@SiSo INT,
	@MaKH VARCHAR(4),
	@TinhTrang BIT
)
AS
BEGIN
	INSERT INTO LOPHOC(MaLop, TenLop, NgayBd, NgayKt, SiSo, MaKH, DangMo)
	VALUES(@MaLop, @TenLop, @NgayBd, @NgayKt, @SiSo, @MaKH, @TinhTrang)
END
