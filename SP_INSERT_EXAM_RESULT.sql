USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_INSERT_EXAM_RESULT]
    @json NVARCHAR(MAX)
AS
BEGIN

    DECLARE @ExamID UNIQUEIDENTIFIER,
            @StudentID VARCHAR(10),
            @Score DECIMAL(5,2),
            @Status NVARCHAR(20),
            @EnteredBy VARCHAR(10),
            @GradingDate DATETIME;


    SELECT
        @ExamID = JSON_VALUE(@json, '$.ExamID'),
        @StudentID = JSON_VALUE(@json, '$.StudentID'),
        @Score = TRY_CAST(JSON_VALUE(@json, '$.Score') AS DECIMAL(5,2)),
        @Status = JSON_VALUE(@json, '$.Status'),
        @EnteredBy = JSON_VALUE(@json, '$.EnteredBy'),
        @GradingDate = TRY_CAST(JSON_VALUE(@json, '$.GradingDate') AS DATETIME);

    INSERT INTO EXAM_RESULT 
    (ResultID, ExamID, StudentID, Score, Status, EnteredBy, GradingDate, DELETE_FLG)
    VALUES 
    (NEWID(), @ExamID, @StudentID, @Score, @Status, @EnteredBy, @GradingDate, 0);
END

