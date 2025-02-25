USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_TEACHER]    Script Date: 2025/01/15 9:46:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_UPDATE_TEACHER]
(
    @json NVARCHAR(MAX)  -- Chuỗi JSON chứa các thông tin cần thiết
)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION
		DECLARE @TeacherInfo TABLE (
			MaGV VARCHAR(10),
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
			MaGV VARCHAR(10),
			TenGV NVARCHAR(30),
			SdtGV VARCHAR(12),
			EmailGV VARCHAR(50),
			GioiTinhGV NVARCHAR(3),
			TenDangNhap VARCHAR(20),
			MatKhau VARCHAR(20)
		);
		SET NOCOUNT OFF;

		UPDATE TK
		SET MatKhau = SOURCE.MatKhau
		FROM TAIKHOAN TK
		JOIN @TeacherInfo SOURCE ON TK.TenDangNhap = SOURCE.TenDangNhap
		WHERE SOURCE.TenDangNhap IS NOT NULL

		UPDATE GV
		SET GV.TenGV = SOURCE.TenGV,
			GV.SdtGV = SOURCE.SdtGV,
			GV.GioiTinhGV = SOURCE.GioiTinhGV,
			GV.EmailGV = SOURCE.EmailGV
		FROM GIANGVIEN GV
		JOIN @TeacherInfo SOURCE ON GV.MaGV = SOURCE.MaGV 

		COMMIT
	End Try 
	Begin Catch 
		 ROLLBACK
	End Catch
END
