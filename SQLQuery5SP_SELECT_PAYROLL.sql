CREATE Or alter PROCEDURE [dbo].[SP_SELECT_PAYROLL]
    @EmployeeID VARCHAR(10) = NULL,
    @TeacherID VARCHAR(10) = NULL,
    @Month INT = NULL,
    @Year INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT 
            p.[PayrollID],
            p.[EmployeeID],
            p.[TeacherID],
            p.[WorkDays],
            p.[TeachingHours],
            p.[RecordDate],
            SUM(p.[TeachingHours]) OVER (PARTITION BY p.[PayrollID]) AS SumHours -- Tổng TeachingHours cho mỗi PayrollID
        FROM [DEV_ACADEMY].[dbo].[Payroll] p
        WHERE 
            (@EmployeeID IS NULL OR p.[EmployeeID] = @EmployeeID)
            AND (@TeacherID IS NULL OR p.[TeacherID] = @TeacherID)
            AND (@Month IS NULL OR MONTH(p.[RecordDate]) = @Month)
            AND (@Year IS NULL OR YEAR(p.[RecordDate]) = @Year)
        GROUP BY 
            p.[PayrollID],
            p.[EmployeeID],
            p.[TeacherID],
            p.[WorkDays],
            p.[TeachingHours],
            p.[RecordDate]
        ORDER BY p.[RecordDate] DESC;
    END TRY
    BEGIN CATCH
        -- Xử lý lỗi nếu có
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO