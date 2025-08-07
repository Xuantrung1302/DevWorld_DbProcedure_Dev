USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_ACCOUNT]    Script Date: 03/07/2025 00:55:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SELECT_PASSWORD_ACCOUNT]
    @Username VARCHAR(20) = NULL,
    @Role VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Username, Password, Role
    FROM ACCOUNT
    WHERE (DELETE_FLG = 0)
        AND (@Username IS NULL OR Username LIKE '%' + @Username + '%')
        AND (@Role IS NULL OR Role = @Role);
END

--EXEC SP_SELECT_PASSWORD_ACCOUNT 'user101'