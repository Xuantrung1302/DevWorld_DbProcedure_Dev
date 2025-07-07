USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_GET_CLASS_STUDENT_COUNT]
    @ClassID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MaxSeats INT;
    DECLARE @CurrentCount INT;

    SELECT 
        @MaxSeats = ISNULL(C.MaxSeats, 0)
    FROM CLASS C
    WHERE C.ClassID = @ClassID;

    IF @MaxSeats IS NULL
    BEGIN
        SELECT 
            CAST(NULL AS INT) AS CurrentCount,
            CAST(NULL AS INT) AS RemainingSeats;
        RETURN;
    END

    SELECT 
        @CurrentCount = COUNT(*)
    FROM CLASS_ENROLLMENT CE
    WHERE CE.ClassID = @ClassID;

    SELECT 
        @CurrentCount AS CurrentCount,
        (@MaxSeats - @CurrentCount) AS RemainingSeats;
END
GO
