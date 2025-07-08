USE [DEV_ACADEMY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_GET_TEACHERS_FOR_ADD_CLASS]
    @ClassID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DaysOfWeek VARCHAR(20),
            @StartTime TIME,
            @EndTime TIME;

    SELECT 
        @DaysOfWeek = DaysOfWeek,
        @StartTime = CAST(StartTime AS TIME),
        @EndTime = CAST(EndTime AS TIME)
    FROM CLASS
    WHERE ClassID = @ClassID;

    SELECT T.TeacherID, T.FullName
    FROM TEACHER T
    WHERE NOT EXISTS (
        SELECT 1
        FROM CLASS C_EXIST
        WHERE C_EXIST.TeacherID = T.TeacherID
          AND (
              EXISTS (
                  SELECT value
                  FROM STRING_SPLIT(C_EXIST.DaysOfWeek, ',')
                  WHERE value IN (SELECT value FROM STRING_SPLIT(@DaysOfWeek, ','))
              )
              AND CAST(C_EXIST.StartTime AS TIME) < @EndTime
              AND CAST(C_EXIST.EndTime AS TIME) > @StartTime
          )
    )
    ORDER BY T.FullName;
END
GO

