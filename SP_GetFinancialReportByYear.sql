CREATE or alter PROCEDURE SP_GetFinancialReportByYear
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Chi decimal(18,2) = 0,
            @DoanhThu decimal(18,2) = 0;

    -- Tính chi phí cho giảng viên
    SELECT @Chi = @Chi + SUM(p.TeachingHours * t.Salary)
    FROM dbo.Payroll p
    INNER JOIN dbo.TEACHER t ON p.TeacherID = t.TeacherID
    WHERE YEAR(p.RecordDate) = @Year;

    -- Tính chi phí cho nhân viên (theo ngày công WorkDays)
    SELECT @Chi = @Chi + SUM(e.Salary)
    FROM dbo.Payroll p
    INNER JOIN dbo.EMPLOYEE e ON p.EmployeeID = e.EmployeeID
    WHERE YEAR(p.RecordDate) = @Year
      AND p.WorkDays = 1;

    -- Tính doanh thu từ hóa đơn đã thanh toán
    SELECT @DoanhThu = SUM(i.Amount)
    FROM dbo.INVOICE i
    WHERE i.Status = N'Đã thanh toán'
      AND YEAR(i.DueDate) = @Year;

    -- Trả kết quả
    SELECT 
        @Year AS Nam,
        ISNULL(@Chi,0) AS TongChi,
        ISNULL(@DoanhThu,0) AS TongDoanhThu,
        ISNULL(@DoanhThu,0) - ISNULL(@Chi,0) AS LoiNhuan;
END;

--exec SP_GetFinancialReportByYear 2025