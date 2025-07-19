USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [SP_COUNT_ENROLLMENT_BY_MONTH_YEAR]
    @Year INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        YEAR(EnrollmentDate) AS [Year],
        MONTH(EnrollmentDate) AS [Month],
        COUNT(*) AS TotalEnrollments
    FROM CLASS_ENROLLMENT
    WHERE 
        (@Year IS NULL OR YEAR(EnrollmentDate) = @Year)
        AND EnrollmentDate IS NOT NULL
    GROUP BY 
        YEAR(EnrollmentDate),
        MONTH(EnrollmentDate)
    ORDER BY 
        [Year], [Month];
END
