USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_SEARCH_CLASS]    Script Date: 2025/01/15 9:44:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-10-02>
-- Description:	<Xuất danh sách và tìm kiếm các lớp học>
-- =============================================
ALTER PROCEDURE [dbo].[SP_SELECT_SEARCH_CLASS]
(
	@MaLop VARCHAR(9) ,
	@TenLop NVARCHAR(30),
	@MaKH VARCHAR(4),
	@NgayBd datetime,
	@NgayKt datetime,
	@TinhTrang BIT
)
AS
BEGIN
	SELECT MaLop, TenLop
	FROM LOPHOC
	WHERE (@MaLop IS NULL OR MaLop LIKE '%' +  @MaLop + '%')
		AND (@TenLop IS NULL OR TenLop LIKE '%' +  @TenLop + '%')
		AND (MaKH = @MaKH OR @MaKH IS NULL)
		AND DangMo = @TinhTrang OR DangMo IS NULL
		AND (NgayBD <= @NgayBd AND NgayKT <= @NgayKt) 
		AND (@TinhTrang IS NULL OR DangMo = @TinhTrang)
END
