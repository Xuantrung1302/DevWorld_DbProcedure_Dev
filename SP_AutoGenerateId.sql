USE [QLHVTTT1]
GO
/****** Object:  StoredProcedure [dbo].[SP_AutoGenerateId]    Script Date: 2025/01/15 9:38:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pham Quang Huy>
-- Create date: <2024-09-30>
-- Description:	<Tạo tự động ID cho các bảng có mã varchar(10)>
-- =============================================
ALTER PROCEDURE [dbo].[SP_AutoGenerateId]
    @NgayBD Date,
    @Prefix NVARCHAR(10),  -- Tham số đầu vào cho tiền tố (GV, HV, NV, PG, LH, KH)
    @NewID NVARCHAR(50) OUTPUT
AS
BEGIN
    DECLARE @BasePrefix NVARCHAR(20) = @Prefix + FORMAT(@NgayBD, 'yyMMdd');
    DECLARE @MaxNumber INT = 0;

    -- Tự động sinh ID cho Giáo viên (GV)
    IF @Prefix = 'GV'
    BEGIN
        SELECT @MaxNumber = MAX(CAST(SUBSTRING(MaGV, LEN(@BasePrefix) + 1, LEN(MaGV) - LEN(@BasePrefix)) AS INT))
        FROM GIANGVIEN
        WHERE MaGV LIKE @BasePrefix + '%';
    END
    -- Tự động sinh ID cho Học viên (HV)
    ELSE IF @Prefix = 'HV'
    BEGIN
        SELECT @MaxNumber = MAX(CAST(SUBSTRING(MaHV, LEN(@BasePrefix) + 1, LEN(MaHV) - LEN(@BasePrefix)) AS INT))
        FROM HOCVIEN
        WHERE MaHV LIKE @BasePrefix + '%';
    END
	-- Tự động sinh ID cho Nhân viên (NV)
    ELSE IF @Prefix = 'NV'
    BEGIN
        SELECT @MaxNumber = MAX(CAST(SUBSTRING(MaNV, LEN(@BasePrefix) + 1, LEN(MaNV) - LEN(@BasePrefix)) AS INT))
        FROM NHANVIEN
        WHERE MaNV LIKE @BasePrefix + '%';
    END
	-- Tự động sinh ID cho Phieu ghi danh (PG)
    ELSE IF @Prefix = 'PG'
    BEGIN
        SELECT @MaxNumber = MAX(CAST(SUBSTRING(MaPhieu, LEN(@BasePrefix) + 1, LEN(MaPhieu) - LEN(@BasePrefix)) AS INT))
        FROM PHIEUGHIDANH
        WHERE MaPhieu LIKE @BasePrefix + '%';
    END
	-- Tự động sinh ID cho Lớp học (LH)
    ELSE IF @Prefix = 'LH'
    BEGIN
        SELECT @MaxNumber = MAX(CAST(SUBSTRING(MaLop, LEN(@BasePrefix) + 1, LEN(MaLop) - LEN(@BasePrefix)) AS INT))
        FROM LOPHOC
        WHERE MaLop LIKE @BasePrefix + '%';
    END

	-- Tự động sinh ID cho Khóa học (KH) với định dạng KH00, KH01, KH02, ...
	ELSE IF @Prefix = 'KH'
	BEGIN
		DECLARE @KHBasePrefix NVARCHAR(2) = 'KH';
		-- Lấy giá trị lớn nhất của mã khóa học từ bảng KHOAHOC
		SELECT @MaxNumber = MAX(CAST(SUBSTRING(MaKH, 3, LEN(MaKH) - 2) AS INT))
		FROM KHOAHOC
		WHERE MaKH LIKE @KHBasePrefix + '%';

	END

	IF @MaxNumber IS NULL
	BEGIN
		SET @MaxNumber = 0;
	END
    
	-- Tạo ID mới cho khóa học với định dạng KH00, KH01, KH02, ...
	SET @NewID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber + 1 AS NVARCHAR), 2);


END
