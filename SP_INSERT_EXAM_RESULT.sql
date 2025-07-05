USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_EXAM_RESULT]
    @ExamID UNIQUEIDENTIFIER,
    @StudentID VARCHAR(10),
    @Score DECIMAL(5,2),
    @Status NVARCHAR(20),
    @EnteredBy VARCHAR(10),
    @GradingDate DATETIME
AS
BEGIN

    INSERT INTO EXAM_RESULT 
    (ResultID, ExamID, StudentID, Score, Status, EnteredBy, GradingDate, DELETE_FLG)
    VALUES 
    (NEWID(), @ExamID, @StudentID, @Score, @Status, @EnteredBy, @GradingDate, 0);
END
GO
