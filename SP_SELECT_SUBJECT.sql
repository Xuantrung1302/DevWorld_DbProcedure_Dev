USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_SELECT_SUBJECT]
    @SubjectID VARCHAR(10) = NULL,
    @SemesterID VARCHAR(10) = NULL,
    @ClassID UNIQUEIDENTIFIER = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT
        S.SubjectID,
        S.SubjectName,
        SM.SemesterName,
        S.TuitionFee
    FROM SUBJECT S
    INNER JOIN SEMESTER SM ON S.SemesterID = SM.SemesterID
    LEFT JOIN CLASS_SCHEDULE CS ON S.SubjectID = CS.SubjectID
    WHERE (S.DELETE_FLG IS NULL OR S.DELETE_FLG = 0)
      AND (SM.DELETE_FLG IS NULL OR SM.DELETE_FLG = 0)
      AND (@SubjectID IS NULL OR S.SubjectID LIKE '%' + @SubjectID + '%')
      AND (@SemesterID IS NULL OR SM.SemesterID = @SemesterID)
      AND (@ClassID IS NULL OR CS.ClassID = @ClassID);
END
