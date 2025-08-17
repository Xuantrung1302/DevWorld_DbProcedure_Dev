USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_INSERT_INVOICE]
    @InvoiceID  VARCHAR(10),
    @StudentID  VARCHAR(10),
    @CourseID   UNIQUEIDENTIFIER,
    @ClassID    UNIQUEIDENTIFIER,
    @Amount     DECIMAL(12,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @StartTime DATETIME;

        -- Lấy ngày bắt đầu sớm nhất của lớp
        SELECT TOP 1 @StartTime = cs.StartTime
        FROM CLASS_SCHEDULE cs
        INNER JOIN CLASS c ON c.ClassID = cs.ClassID
        INNER JOIN COURSE co ON co.course_id = c.course_id
        WHERE c.course_id = @CourseID 
          AND cs.ClassID = @ClassID
        ORDER BY cs.StartTime ASC;

        -- Nếu không có lịch thì mặc định lấy ngày hiện tại
        IF @StartTime IS NULL
            SET @StartTime = GETDATE();

        -- Insert vào hóa đơn
        INSERT INTO INVOICE 
        (
            InvoiceID, 
            StudentID, 
            course_id,
            InvoiceDate, 
            DueDate, 
            Amount, 
            DELETE_FLG, 
            Status
        )
        VALUES
        (
            @InvoiceID, 
            @StudentID, 
            @CourseID, 
            @StartTime,   -- ngày tạo hóa đơn
            @StartTime,   -- hạn thanh toán = ngày bắt đầu lớp
            @Amount, 
            0, 
            N'Chưa thanh toán'
        );

        COMMIT TRANSACTION;
        RETURN 1; -- Success
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN 0; -- Failure
    END CATCH;
END
GO




