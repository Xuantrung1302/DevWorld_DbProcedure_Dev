USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_EMPLOYEE]    Script Date: 2025/01/15 9:43:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_INSERT_EMPLOYEE]
(
    @MaNV VARCHAR(10),
    @TenNV NVARCHAR(30),
    @SdtNV VARCHAR(12),
    @EmailNV VARCHAR(50),
    @MaLoaiNV VARCHAR(5),
    @TenDangNhap VARCHAR(20),
    @MatKhau VARCHAR(20)
)
AS
BEGIN
    -- Bắt đầu transaction
    BEGIN TRANSACTION;
    
    BEGIN TRY
        -- Kiểm tra sự tồn tại của MaLoaiNV trong bảng LOAINV
        IF NOT EXISTS (SELECT 1 FROM LOAINV WHERE MaLoaiNV = @MaLoaiNV)
        BEGIN
            RAISERROR('MaLoaiNV không tồn tại trong bảng LOAINV', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        -- Insert vào bảng NHANVIEN
        
        -- Insert vào bảng TAIKHOAN
        INSERT INTO TAIKHOAN(TenDangNhap, MatKhau)
        VALUES (@TenDangNhap, @MatKhau);

		INSERT INTO NHANVIEN(MaNV, TenNV, SdtNV, EmailNV, MaLoaiNV, TenDangNhap)
        VALUES (@MaNV, @TenNV, @SdtNV, @EmailNV, @MaLoaiNV, @TenDangNhap);

        -- Commit transaction nếu không có lỗi
        COMMIT TRANSACTION;
    END TRY
    
    BEGIN CATCH
        -- Rollback transaction nếu có lỗi xảy ra
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
