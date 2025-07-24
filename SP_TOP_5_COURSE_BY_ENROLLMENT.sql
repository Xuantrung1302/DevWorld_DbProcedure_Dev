USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [SP_TOP_5_COURSE_BY_ENROLLMENT]
    @Year INT = NULL
AS
BEGIN
    SELECT TOP 5
        c.course_id,
        c.course_name,
        COUNT(ce.EnrollmentID) AS TotalStudents
    FROM CLASS_ENROLLMENT ce
    JOIN CLASS cls ON ce.ClassID = cls.ClassID
    JOIN COURSE c ON cls.course_id = c.course_id
    WHERE (@Year IS NULL OR YEAR(ce.EnrollmentDate) = @Year)
    GROUP BY c.course_id, c.course_name
    ORDER BY TotalStudents DESC
END

