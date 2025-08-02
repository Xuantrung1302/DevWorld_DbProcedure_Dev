CREATE PROCEDURE [dbo].[SP_INSERT_PAYROLL]
    @EmployeeID Varchar(10),
    @TeacherID Varchar(10),
    @WorkDays Varchar(10),
    @TeachingHours DECIMAL(5,2), -- Giả sử TeachingHours có thể là số thập phân (ví dụ: 10.5 giờ)
    @RecordDate DATETime
AS
BEGIN
    --SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [DEV_ACADEMY].[dbo].[Payroll]
            ([EmployeeID], [TeacherID], [WorkDays], [TeachingHours], [RecordDate])
        VALUES
            (@EmployeeID, @TeacherID, @WorkDays, @TeachingHours, @RecordDate);

        -- Trả về PayrollID của bản ghi vừa chèn (nếu cần)
        SELECT SCOPE_IDENTITY() AS PayrollID;
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