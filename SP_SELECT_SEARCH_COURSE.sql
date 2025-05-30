USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_SEARCH_COURSE]    Script Date: 2025/01/15 9:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_SELECT_SEARCH_COURSE]
(
    @MaKH VARCHAR(4) = NULL,
    @TenKH NVARCHAR(30) = NULL
)
AS
BEGIN
    SELECT 
        MaKH, 
        TenKH, 
        HocPhi, 
        HeSoLyThuyet, 
        HeSoThucHanh, 
        HeSoDuAn, 
        HeSoCuoiKy
    FROM KHOAHOC
    WHERE (@MaKH IS NULL OR MaKH LIKE '%' + @MaKH + '%') 
        AND (@TenKH IS NULL OR TenKH LIKE '%' + @TenKH + '%') 
END
