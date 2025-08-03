USE [DEV_ACADEMY]
GO

/****** Object:  StoredProcedure [dbo].[SP_SELECT_ACCOUNT_BY_ROLE]    Script Date: 03/08/2025 02:30:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SELECT_ACCOUNT_BY_ROLE]
    @RoleId Varchar(1)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @RoleId = '1' -- Employee và Admin
        BEGIN
            SELECT 
                e.EmployeeID AS ID,
                e.FullName
            FROM ACCOUNT a
            LEFT JOIN EMPLOYEE e ON e.UserName = a.UserName
            WHERE a.Role IN ('Employee', 'Admin');
        END
        ELSE IF @RoleId = '2' -- Teacher
        BEGIN
            SELECT 
                t.TeacherID  AS ID,
                t.FullName
            FROM ACCOUNT a
            LEFT JOIN TEACHER t ON t.UserName = a.UserName
            WHERE a.Role = 'Teacher';
        END
        ELSE IF @RoleId = '3' -- Student
        BEGIN
            SELECT 
                s.StudentID  AS ID,
                s.FullName
            FROM ACCOUNT a
            LEFT JOIN STUDENT s ON s.UserName = a.UserName
            WHERE a.Role = 'Student';
        END
        ELSE
        BEGIN
            -- Trả về rỗng nếu @RollType không hợp lệ
            SELECT NULL AS ID, NULL AS [FullName] WHERE 1 = 0;
        END
    END TRY
    BEGIN CATCH
        -- Xử lý lỗi nếu có
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO


--EXEC [dbo].[SP_SELECT_ACCOUNT_BY_ROLE] @RoleId = 1; -- Lấy Employee và Admin
--EXEC [dbo].[SP_SELECT_ACCOUNT_BY_ROLE] @RoleId = 2; -- Lấy Teacher
--EXEC [dbo].[SP_SELECT_ACCOUNT_BY_ROLE] @RoleId = 3; -- Lấy Student