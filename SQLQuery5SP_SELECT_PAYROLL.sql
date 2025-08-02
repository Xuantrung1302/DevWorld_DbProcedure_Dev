CREATE PROCEDURE [dbo].[SP_SELECT_PAYROLL]
    @EmployeeID Varchar(10),
    @TeacherID Varchar(10)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT 
            [PayrollID],
            [EmployeeID],
            [TeacherID],
            [WorkDays],
            [TeachingHours],
            [RecordDate]
        FROM [DEV_ACADEMY].[dbo].[Payroll]
        WHERE 
            [EmployeeID] = @EmployeeID
            AND [TeacherID] = @TeacherID
        ORDER BY [RecordDate] DESC;
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