USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_TEACHER]    Script Date: 2025/01/15 9:43:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<NGUYEN XUAN TRUNG>
-- Create date: <2024-10-05>
-- Description:	<Thêm giảng viên>
-- =============================================
ALTER PROCEDURE [dbo].[SP_INSERT_TEACHER]
(
	@json NVARCHAR(Max)
)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION
		DECLARE @TeacherInfo TABLE (
			MaGV VARCHAR(6),
			TenGV NVARCHAR(30),
			SdtGV VARCHAR(12),
			EmailGV VARCHAR(50),
			GioiTinhGV NVARCHAR(3),
			TenDangNhap VARCHAR(20),
			MatKhau VARCHAR(20)
		);

		INSERT INTO @TeacherInfo
		SELECT *
		FROM OPENJSON(@json)
		WITH 
		(
			MaGV VARCHAR(6),
			TenGV NVARCHAR(30),
			SdtGV VARCHAR(12),
			EmailGV VARCHAR(50),
			GioiTinhGV NVARCHAR(3),
			TenDangNhap VARCHAR(20),
			MatKhau VARCHAR(20)
		);
		SET NOCOUNT OFF;
		INSERT INTO TaiKhoan (TenDangNhap, MatKhau)
		SELECT TenDangNhap, MatKhau
		FROM @TeacherInfo;

		-- Chèn dữ liệu từ bảng tạm vào bảng GIANGVIEN
		INSERT INTO GIANGVIEN (MaGV, TenGV, GioiTinhGV, SdtGV, EmailGV, TenDangNhap)
		SELECT MaGV, TenGV, GioiTinhGV, SdtGV, EmailGV, TenDangNhap
		FROM @TeacherInfo;

		-- Commit nếu tất cả các lệnh thành công
		COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
			-- Rollback nếu có lỗi
			IF @@TRANCOUNT > 0
				ROLLBACK TRANSACTION;

			-- Trả về lỗi
			THROW;
		END CATCH;
END
