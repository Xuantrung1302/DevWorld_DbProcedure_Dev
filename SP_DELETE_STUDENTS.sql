USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_STUDENTS]    Script Date: 2025/01/15 9:41:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_DELETE_STUDENTS]
(
	@MaHV VARCHAR(6),
	@TenDangNhap VARCHAR(20),
	@MaLoaiHV Varchar(5)
)
AS
BEGIN
    -- Nếu loại học viên là LHV01 thì xóa tài khoản
    IF @MaLoaiHV = 'LHV01'
    BEGIN
        DELETE FROM TaiKhoan
        WHERE TenDangNhap = @TenDangNhap;
    END

    -- Xóa bản ghi trong bảng HOCVIEN
    DELETE FROM HOCVIEN
    WHERE MaHV = @MaHV;

END
