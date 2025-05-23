USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_KHOAHOC]    Script Date: 2025/01/15 9:46:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-10-25>
-- Description:	<Sửa KHÓA HỌC>
-- =============================================

ALTER PROCEDURE [dbo].[SP_UPDATE_KHOAHOC]
(
    @MaKH VARCHAR(4),
    @TenKH NVARCHAR(30) = NULL,
    @HocPhi MONEY = NULL,
    @HeSoLyThuyet INT = NULL,
    @HeSoThucHanh INT = NULL,
    @HeSoDuAn INT = NULL,
    @HeSoCuoiKy INT = NULL
)
AS
BEGIN
    UPDATE KHOAHOC
    SET 
        TenKH = COALESCE(@TenKH, TenKH),                  -- Cập nhật tên khóa học nếu có giá trị mới
        HocPhi = COALESCE(@HocPhi, HocPhi),                -- Cập nhật học phí nếu có giá trị mới
        HeSoLyThuyet = COALESCE(@HeSoLyThuyet, HeSoLyThuyet),  -- Cập nhật hệ số lý thuyết
        HeSoThucHanh = COALESCE(@HeSoThucHanh, HeSoThucHanh),  -- Cập nhật hệ số thực hành
        HeSoDuAn = COALESCE(@HeSoDuAn, HeSoDuAn),          -- Cập nhật hệ số dự án
        HeSoCuoiKy = COALESCE(@HeSoCuoiKy, HeSoCuoiKy)    -- Cập nhật hệ số cuối kỳ
    WHERE MaKH = @MaKH                                    -- Điều kiện để xác định khóa học cần cập nhật
END
