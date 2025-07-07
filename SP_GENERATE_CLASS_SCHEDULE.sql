USE [DEV_ACADEMY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_GENERATE_CLASS_SCHEDULE]
    @ClassID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ClassName VARCHAR(50),
            @DaysOfWeek VARCHAR(20),
            @StartTime DATETIME,
            @EndTime DATETIME,
            @SemesterID VARCHAR(10),
            @SemesterStartDate DATETIME,
            @SemesterEndDate DATETIME;

    SELECT 
        @ClassName = C.ClassName,
        @DaysOfWeek = C.DaysOfWeek,
        @StartTime = C.StartTime,
        @EndTime = C.EndTime,
        @SemesterID = S.SemesterID
    FROM CLASS C
    INNER JOIN SUBJECT SJ ON C.SubjectID = SJ.SubjectID
    INNER JOIN SEMESTER S ON SJ.SemesterID = S.SemesterID
    WHERE C.ClassID = @ClassID;

    SELECT 
        @SemesterStartDate = StartDate,
        @SemesterEndDate = EndDate
    FROM SEMESTER
    WHERE SemesterID = @SemesterID;

    DECLARE @CurrentDate DATE = @SemesterStartDate;
    DECLARE @WeekDayNum VARCHAR(2);

    DECLARE @DayCount TABLE
    (
        DayNum VARCHAR(2) PRIMARY KEY,
        Count INT
    );

    DECLARE @pos INT = 0, @nextPos INT, @len INT;
    DECLARE @day VARCHAR(2);
    SET @DaysOfWeek = @DaysOfWeek + ',';
    SET @len = LEN(@DaysOfWeek);

    WHILE @pos < @len
    BEGIN
        SET @nextPos = CHARINDEX(',', @DaysOfWeek, @pos + 1);
        SET @day = SUBSTRING(@DaysOfWeek, @pos + 1, @nextPos - @pos - 1);

        INSERT INTO @DayCount(DayNum, Count) VALUES (@day, 0);

        SET @pos = @nextPos;
    END

    WHILE @CurrentDate <= @SemesterEndDate
    BEGIN
        SET @WeekDayNum = CAST(DATEPART(WEEKDAY, @CurrentDate) AS VARCHAR);

        IF EXISTS (SELECT 1 FROM @DayCount WHERE DayNum = @WeekDayNum AND Count < 8)
        BEGIN
            INSERT INTO CLASS_SCHEDULE (Class_ScheID, ClassID, ClassName, DayOfWeek, StartTime, EndTime)
            VALUES 
            (
                NEWID(), 
                @ClassID, 
                @ClassName, 
                @WeekDayNum, 
                DATEADD(HOUR, DATEPART(HOUR, @StartTime), CAST(@CurrentDate AS DATETIME)),
                DATEADD(HOUR, DATEPART(HOUR, @EndTime), CAST(@CurrentDate AS DATETIME))
            );

            UPDATE @DayCount
            SET Count = Count + 1
            WHERE DayNum = @WeekDayNum;
        END

        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
    END
END
GO
