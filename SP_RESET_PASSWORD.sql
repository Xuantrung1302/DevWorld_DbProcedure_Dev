CREATE OR ALTER PROCEDURE SP_RESET_PASSWORD
    @Username VARCHAR(20),
    @NewPassword VARCHAR(30)
AS
BEGIN
    UPDATE ACCOUNT
    SET Password = @NewPassword
    WHERE Username = @Username AND DELETE_FLG = 0;
END
