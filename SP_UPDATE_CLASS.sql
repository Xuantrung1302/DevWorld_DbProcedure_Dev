USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_UPDATE_CLASS]
    @ClassID UNIQUEIDENTIFIER,
    @CourseID UNIQUEIDENTIFIER, 
    @ClassName VARCHAR(50),
    @StartTime DATETIME,
    @EndTime DATETIME,
    @Room VARCHAR(10),
    @TeacherID VARCHAR(10),
    @MaxSeats INT = NULL,
    @DaysOfWeek VARCHAR(20) = NULL,
    @StudentCount INT = NULL,
	@Status INT = NULL
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS (
            SELECT 1
            FROM CLASS C
            WHERE C.ClassID <> @ClassID 
              AND C.Room = @Room
              AND EXISTS (
                  SELECT value
                  FROM STRING_SPLIT(C.DaysOfWeek, ',')
                  WHERE value IN (SELECT value FROM STRING_SPLIT(@DaysOfWeek, ','))
              )
              AND CAST(C.StartTime AS TIME) < CAST(@EndTime AS TIME)
              AND CAST(C.EndTime AS TIME) > CAST(@StartTime AS TIME)
        )
        BEGIN
            RAISERROR('Room is already booked at this time slot by another class.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN 0;
        END

        UPDATE CLASS
        SET 
            course_id = @CourseID, 
            ClassName = @ClassName,
            StartTime = @StartTime,
            EndTime = @EndTime,
            Room = @Room,
            TeacherID = @TeacherID,
            MaxSeats = @MaxSeats,
            DaysOfWeek = @DaysOfWeek,
            StudentCount = @StudentCount,
			Status = @Status
        WHERE ClassID = @ClassID;

        IF @@ROWCOUNT = 0
        BEGIN
            ROLLBACK;
            RAISERROR('Class not found.', 16, 1);
            RETURN 0;
        END

        COMMIT TRANSACTION;
        RETURN 1;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN 0;
    END CATCH;
END
GO