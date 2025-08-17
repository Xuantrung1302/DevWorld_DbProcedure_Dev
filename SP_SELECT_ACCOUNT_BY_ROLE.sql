ALTER PROCEDURE [dbo].[SP_SELECT_ACCOUNT_BY_ROLE]
    @RoleId VARCHAR(1),
    @CurrentUserID varchar(10) = null
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
            WHERE a.Role IN ('Employee', 'Admin')
              AND e.EmployeeID <> @CurrentUserID
              AND NOT EXISTS (
                  SELECT 1 FROM Messages m
                  WHERE (m.SenderID = e.EmployeeID AND m.ReceiverID = @CurrentUserID)
                     OR (m.ReceiverID = e.EmployeeID AND m.SenderID = @CurrentUserID)
              );
        END
        ELSE IF @RoleId = '2' -- Teacher
        BEGIN
            SELECT 
                t.TeacherID AS ID,
                t.FullName
            FROM ACCOUNT a
            LEFT JOIN TEACHER t ON t.UserName = a.UserName
            WHERE a.Role = 'Teacher'
              AND t.TeacherID <> @CurrentUserID
              AND NOT EXISTS (
                  SELECT 1 FROM Messages m
                  WHERE (m.SenderID = t.TeacherID AND m.ReceiverID = @CurrentUserID)
                     OR (m.ReceiverID = t.TeacherID AND m.SenderID = @CurrentUserID)
              );
        END
        ELSE IF @RoleId = '3' -- Student
        BEGIN
            SELECT 
                s.StudentID AS ID,
                s.FullName
            FROM ACCOUNT a
            LEFT JOIN STUDENT s ON s.UserName = a.UserName
            WHERE a.Role = 'Student'
              AND s.StudentID <> @CurrentUserID
              AND NOT EXISTS (
                  SELECT 1 FROM Messages m
                  WHERE (m.SenderID = s.StudentID AND m.ReceiverID = @CurrentUserID)
                     OR (m.ReceiverID = s.StudentID AND m.SenderID = @CurrentUserID)
              );
        END
        ELSE
        BEGIN
            -- Trả về rỗng nếu @RoleId không hợp lệ
            SELECT NULL AS ID, NULL AS [FullName] WHERE 1 = 0;
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

