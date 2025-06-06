USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_CLASS]    Script Date: 2025/01/15 9:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nguyen Xuan Trung>
-- Create date: <2024-10-04>
-- Description:	<XÓA lớp học>
-- =============================================

ALTER PROCEDURE [dbo].[SP_DELETE_CLASS]
    @MaLop varchar(9)
AS
BEGIN
    -- Kiểm tra MaLop có tồn tại không
    IF EXISTS (SELECT 1 FROM LOPHOC WHERE MaLop = @MaLop)
    BEGIN
        -- Xóa các bản ghi trong bảng GIANGDAY liên quan đến MaLop
        DELETE FROM GIANGDAY WHERE MaLop = @MaLop

        -- Xóa các bản ghi trong bảng BANGDIEM liên quan đến MaLop
        DELETE FROM BANGDIEM WHERE MaLop = @MaLop

        -- Xóa lớp học trong LOPHOC
        DELETE FROM LOPHOC WHERE MaLop = @MaLop
    END
    ELSE
    BEGIN
        PRINT 'Lớp học không tồn tại, không thể xóa!'
    END
END
