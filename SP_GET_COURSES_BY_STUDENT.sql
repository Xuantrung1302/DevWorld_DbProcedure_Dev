USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [SP_GET_COURSES_BY_STUDENT]
    @StudentID VARCHAR(10)
AS
BEGIN
    SELECT DISTINCT
        C.course_id,
        C.course_code,
        C.course_name,
        C.is_active,
        C.created_at,
        C.updated_at
    FROM STUDENT S
JOIN ATTENDANCE_RECORD A ON S.StudentID = A.StudentID
JOIN CLASS_SCHEDULE CS ON A.Class_ScheID = CS.Class_ScheID
JOIN CLASS CL ON CS.ClassID = CL.ClassID
JOIN COURSE C ON CL.course_id = C.course_id
    WHERE S.StudentID = @StudentID
END


