USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_NOTICE]    Script Date: 03/07/2025 00:05:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_SELECT_NOTICE]
	
AS
BEGIN
	--SET NOCOUNT ON;
	SELECT N.NewsID, N.Title, N.Content, N.PostDate, N.PostedBy, E.FullName
    FROM NEWSBOARD N
	INNER JOIN ACCOUNT A ON A.Username = N.PostedBy
    INNER JOIN EMPLOYEE E ON E.Username = A.Username;

END