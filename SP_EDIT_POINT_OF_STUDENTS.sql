USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_EDIT_POINT_OF_STUDENTS]    Script Date: 2025/01/15 9:42:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-10-02>
-- Description:	<Sửa 4 đầu điểm: nghe nói đọc việt của học viên>
-- =============================================
ALTER PROCEDURE [dbo].[SP_EDIT_POINT_OF_STUDENTS]
(
	@maHv varchar(9),
	@diemLyThuyet int,
	@diemThucHanh int,
	@diemDuAn int,
	@diemCuoiKy int
)
AS
BEGIN
	update BANGDIEM 
	set DiemLyThuyet = @diemLyThuyet, DiemThucHanh = @diemThucHanh, DiemDuAn = @diemDuAn, DiemCuoiKy = @diemCuoiKy
	where MaHV = @maHv
END
