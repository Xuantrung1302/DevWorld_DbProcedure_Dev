USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_UPDATE_EXAM_RESULT]
    @ResultID UNIQUEIDENTIFIER,
    @Score DECIMAL(5,2),
    @Status NVARCHAR(20),
    @EnteredBy VARCHAR(10),
    @GradingDate DATETIME
AS
BEGIN

    UPDATE EXAM_RESULT
    SET Score = @Score,
        Status = @Status,
        EnteredBy = @EnteredBy,
        GradingDate = @GradingDate
    WHERE ResultID = @ResultID AND DELETE_FLG = 0;
END
GO
