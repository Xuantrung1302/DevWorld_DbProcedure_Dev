USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_COURSE]    Script Date: 2025/01/15 9:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-10-25>
-- Description:	<THÊM KHÓA HỌC>
-- =============================================
ALTER PROCEDURE [dbo].[SP_INSERT_COURSE]
(
    @MaKH VARCHAR(4),
    @TenKH NVARCHAR(30),
    @HocPhi MONEY,
    @HeSoLyThuyet INT,
    @HeSoThucHanh INT,
    @HeSoDuAn INT,
    @HeSoCuoiKy INT
)
AS
BEGIN
    INSERT INTO KHOAHOC (MaKH, TenKH, HocPhi, HeSoLyThuyet, HeSoThucHanh, HeSoDuAn, HeSoCuoiKy)
    VALUES (@MaKH, @TenKH, @HocPhi, @HeSoLyThuyet, @HeSoThucHanh, @HeSoDuAn, @HeSoCuoiKy)
END
