USE [DEV_ACADEMY]
GO
ALTER PROCEDURE SP_GENERATE_CLASS_SCHEDULE
    @ClassID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DaysOfWeek VARCHAR(20),
            @StartTime TIME,
            @EndTime TIME,
            @SemesterID VARCHAR(10),
            @SemesterStart DATE,
            @SemesterEnd DATE,
            @SubjectID VARCHAR(10),
            @Lessons INT,
            @CurrentDate DATE,
            @NextSubjectStartDate DATE;

    SELECT 
        @DaysOfWeek = DaysOfWeek,
        @StartTime = CAST(StartTime AS TIME),
        @EndTime = CAST(EndTime AS TIME)
    FROM CLASS 
    WHERE ClassID = @ClassID;

    DECLARE semester_cursor CURSOR FOR
    SELECT DISTINCT S.SemesterID, S.StartDate, S.EndDate
    FROM CLASS C
    JOIN Course CO ON C.course_id = CO.course_id
    JOIN SEMESTER S ON S.course_id = CO.course_id
    WHERE C.ClassID = @ClassID
    ORDER BY S.StartDate;

    OPEN semester_cursor;
    FETCH NEXT FROM semester_cursor INTO @SemesterID, @SemesterStart, @SemesterEnd;

    SET @NextSubjectStartDate = @SemesterStart;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE subject_cursor CURSOR FOR
        SELECT SubjectID
        FROM SUBJECT
        WHERE SemesterID = @SemesterID AND DELETE_FLG = 0
        ORDER BY SubjectID;

        OPEN subject_cursor;
        FETCH NEXT FROM subject_cursor INTO @SubjectID;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @Lessons = 0;
            SET @CurrentDate = @NextSubjectStartDate;

            WHILE @Lessons < 8 AND @CurrentDate <= @SemesterEnd
            BEGIN
                IF CHARINDEX(CAST(DATEPART(WEEKDAY, @CurrentDate) AS VARCHAR), @DaysOfWeek) > 0
                BEGIN
                    INSERT INTO CLASS_SCHEDULE (
                        Class_ScheID, ClassID, ClassName, DayOfWeek, StartTime, EndTime, SubjectID
                    )
                    SELECT 
                        NEWID(), @ClassID, C.ClassName, 
                        CAST(DATEPART(WEEKDAY, @CurrentDate) AS VARCHAR),
                        CAST(DATEADD(HOUR, DATEPART(HOUR, @StartTime), CAST(@CurrentDate AS DATETIME)) AS DATETIME),
                        CAST(DATEADD(HOUR, DATEPART(HOUR, @EndTime), CAST(@CurrentDate AS DATETIME)) AS DATETIME),
                        @SubjectID
                    FROM CLASS C
                    WHERE C.ClassID = @ClassID;

                    SET @Lessons = @Lessons + 1;
                END
                SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
            END

            SET @NextSubjectStartDate = DATEADD(DAY, 1, @CurrentDate);
            FETCH NEXT FROM subject_cursor INTO @SubjectID;
        END

        CLOSE subject_cursor;
        DEALLOCATE subject_cursor;

        FETCH NEXT FROM semester_cursor INTO @SemesterID, @SemesterStart, @SemesterEnd;
    END

    CLOSE semester_cursor;
    DEALLOCATE semester_cursor;
END
GO
