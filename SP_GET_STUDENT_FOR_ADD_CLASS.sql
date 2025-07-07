USE [DEV_ACADEMY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_GET_STUDENT_FOR_ADD_CLASS]
    @ClassID UNIQUEIDENTIFIER
AS
BEGIN

    SELECT 
        S.StudentID, 
        S.FullName
    FROM STUDENT S
    WHERE 

        S.StudentID NOT IN (
            SELECT CE.StudentID
            FROM CLASS_ENROLLMENT CE
            WHERE CE.ClassID = @ClassID
        )
        AND

        NOT EXISTS (
            SELECT 1
            FROM CLASS_ENROLLMENT CE
            INNER JOIN CLASS_SCHEDULE CS_EXIST 
                ON CE.ClassID = CS_EXIST.ClassID
            INNER JOIN CLASS_SCHEDULE CS_NEW
                ON CS_NEW.ClassID = @ClassID
            WHERE CE.StudentID = S.StudentID
              AND CS_EXIST.DayOfWeek = CS_NEW.DayOfWeek
              AND (
                    CS_EXIST.StartTime < CS_NEW.EndTime 
                    AND CS_EXIST.EndTime > CS_NEW.StartTime
                  )
        )
    ORDER BY S.FullName
END
GO
