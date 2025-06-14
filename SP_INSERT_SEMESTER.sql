USE [HELLO_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_SEMESTER]    Script Date: 16/06/2025 00:14:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 13. SP_INSERT_SEMESTER
ALTER PROCEDURE [dbo].[SP_INSERT_SEMESTER]
    @SemesterID VARCHAR(10),
    @SemesterName NVARCHAR(100),
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    INSERT INTO SEMESTER(SemesterID, SemesterName, StartDate, EndDate)
    VALUES (@SemesterID, @SemesterName, @StartDate, @EndDate);
END
