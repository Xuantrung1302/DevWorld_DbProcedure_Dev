USE [HELLO_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_KYHOC]    Script Date: 16/06/2025 00:11:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 35. SP_UPDATE_KYHOC
CREATE PROCEDURE [dbo].[SP_UPDATE_SEMESTER]
    @SemesterID VARCHAR(10),
    @SemesterName NVARCHAR(100) = NULL,
    @StartDate MONEY = NULL,
    @EndDate INT = NULL
AS
BEGIN
    UPDATE SEMESTER
    SET SemesterName = COALESCE(@SemesterName, SemesterName),
        [StartDate] = COALESCE(@StartDate, [StartDate]),
        [EndDate] = COALESCE(@EndDate, [EndDate])
    WHERE SemesterID = @SemesterID;
END
