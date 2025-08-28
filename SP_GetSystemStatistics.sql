USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create or ALTER PROCEDURE SP_GetSystemStatistics
AS
BEGIN
    SET NOCOUNT ON;

    SELECT N'Học viên' AS LoaiDoiTuong, COUNT(*) AS SoLuong
    FROM dbo.STUDENT
    UNION ALL
    SELECT N'Giảng viên', COUNT(*)
    FROM dbo.TEACHER
    UNION ALL
    SELECT N'Nhân viên', COUNT(*)
    FROM dbo.EMPLOYEE
    UNION ALL
    SELECT N'Khóa học', COUNT(*)
    FROM dbo.Course;
END;