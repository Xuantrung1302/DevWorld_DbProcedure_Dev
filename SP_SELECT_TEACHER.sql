USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_TEACHER]    Script Date: 02/07/2025 22:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_TEACHER]
    @TeacherID VARCHAR(10) = NULL,
    @FullName NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT T.TeacherID, T.FullName, T.Gender, T.PhoneNumber, T.Address, T.Email, T.Degree, T.Username
    FROM TEACHER T
    WHERE (T.DELETE_FLG = 0)
        AND (@TeacherID IS NULL OR T.TeacherID LIKE '%' + @TeacherID + '%')
        AND (@FullName IS NULL OR T.FullName LIKE '%' + @FullName + '%');
END
