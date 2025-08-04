CREATE OR ALTER PROCEDURE SP_INSERT_WORKDAY
    @EmployeeID VARCHAR(10),
    @RecordDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra đã có công hôm nay chưa
    IF NOT EXISTS (
        SELECT 1 FROM PAYROLL
        WHERE EmployeeID = @EmployeeID
          AND RecordDate = @RecordDate
          AND WorkDays = 1
    )
    BEGIN
        INSERT INTO PAYROLL (PayrollID, EmployeeID, WorkDays, RecordDate)
        VALUES (NEWID(), @EmployeeID, 1, @RecordDate);
    END
END
