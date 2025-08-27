CREATE PROCEDURE [dbo].[SP_GET_EMPLOYEES_BY_MONTH_YEAR]
    @Month INT,
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT DISTINCT 
            p.[EmployeeID],
            u.[FullName]
        FROM [DEV_ACADEMY].[dbo].[Payroll] p
        INNER JOIN [DEV_ACADEMY].[dbo].[EMPLOYEE] u ON p.EmployeeID = u.EmployeeID -- Giả định bảng Users chứa thông tin giảng viên
        WHERE 
            MONTH(p.[RecordDate]) = @Month
            AND YEAR(p.[RecordDate]) = @Year;
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