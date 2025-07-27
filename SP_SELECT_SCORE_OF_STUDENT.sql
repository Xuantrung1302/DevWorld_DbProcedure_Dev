USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_SELECT_SCORE_OF_STUDENT]
    @StudentID VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        CR.course_id AS CourseID,
        CR.course_name AS CourseName,
        SJ.SubjectID,
        SJ.SubjectName,
        ER.Score
    FROM EXAM_RESULT ER
    INNER JOIN EXAM_SCHEDULE ES ON ER.ExamID = ES.ExamID
    INNER JOIN CLASS C ON ES.ClassID = C.ClassID
    INNER JOIN SUBJECT SJ ON ES.SubjectID = SJ.SubjectID
    INNER JOIN SEMESTER SM ON SJ.SemesterID = SM.SemesterID
    INNER JOIN COURSE CR ON SM.course_id = CR.course_id
    WHERE ER.StudentID = @StudentID
END