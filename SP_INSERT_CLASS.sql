USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_INSERT_CLASS]
    @ClassID UNIQUEIDENTIFIER,
    @SubjectID VARCHAR(10),
    @ClassName VARCHAR(50),
    @StartTime DATETIME,
    @EndTime DATETIME,
    @Room VARCHAR(10),
    @TeacherID VARCHAR(10),
    @MaxSeats INT = NULL,
    @DaysOfWeek VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS (
            SELECT 1
            FROM CLASS C
            WHERE C.Room = @Room
              AND EXISTS (
                  SELECT value
                  FROM STRING_SPLIT(C.DaysOfWeek, ',')
                  WHERE value IN (SELECT value FROM STRING_SPLIT(@DaysOfWeek, ','))
              )
              AND CAST(C.StartTime AS TIME) < CAST(@EndTime AS TIME)
              AND CAST(C.EndTime AS TIME) > CAST(@StartTime AS TIME)
        )
        BEGIN
            RAISERROR('Room is already booked at this time slot.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN 0;
        END

        -- Insert lớp
        INSERT INTO CLASS 
        (ClassID, SubjectID, ClassName, StartTime, EndTime, Room, TeacherID, MaxSeats, DaysOfWeek)
        VALUES 
        (@ClassID, @SubjectID, @ClassName, @StartTime, @EndTime, @Room, @TeacherID, @MaxSeats, @DaysOfWeek);

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
