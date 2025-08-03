CREATE PROCEDURE [dbo].[SP_SELECT_SCORE_OF_STUDENT_BY_CLASS]
    @ClassID UNIQUEIDENTIFIER = NULL,
    @StudentID VARCHAR(10) = NULL
AS
BEGIN
    SELECT 
        S.SubjectName,
        C.ClassName,
        Se.SemesterName,
        St.StudentID,
        St.FullName,

        -- Điểm giữa kỳ
        MAX(CASE WHEN E.ExamType = N'Giữa kỳ' THEN ER.Score END) AS ScoreMid,

        -- Điểm cuối kỳ
        MAX(CASE WHEN E.ExamType = N'Cuối kỳ' THEN ER.Score END) AS ScoreEnd

    FROM EXAM_RESULT ER
    INNER JOIN EXAM_SCHEDULE E ON ER.ExamID = E.ExamID
    INNER JOIN CLASS C ON E.ClassID = C.ClassID
    INNER JOIN SUBJECT S ON C.SubjectID = S.SubjectID
    INNER JOIN SEMESTER Se ON S.SemesterID = Se.SemesterID
    INNER JOIN STUDENT St ON ER.StudentID = St.StudentID

    WHERE ER.DELETE_FLG = 0
      AND (@ClassID IS NULL OR C.ClassID = @ClassID)
      AND (@StudentID IS NULL OR St.StudentID = @StudentID)

    GROUP BY 
        S.SubjectName,
        C.ClassName,
        Se.SemesterName,
        St.StudentID,
        St.FullName
END

select * from STUDENT


--exec SP_SELECT_SCORE_OF_STUDENT_BY_CLASS '5B147719-B4B8-43CD-A4C4-8494949B107B', 'HV00000002'