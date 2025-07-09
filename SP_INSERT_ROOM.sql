USE [DEV_ACADEMY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_ROOM]
    @RoomID NVARCHAR(20),
    @RoomName NVARCHAR(100),
    @MaxSeats INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS (SELECT 1 FROM ROOM WHERE RoomID = @RoomID)
        BEGIN
            RAISERROR('RoomID da ton tai.', 16, 1);
            ROLLBACK;
            RETURN 0;
        END

        INSERT INTO ROOM (RoomID, RoomName, MaxSeats)
        VALUES (@RoomID, @RoomName, @MaxSeats);

        COMMIT TRANSACTION;
        RETURN 1;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN 0;
    END CATCH
END
GO
