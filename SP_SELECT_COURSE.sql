USE [DEV_ACADEMY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_SELECT_COURSE]
    @CourseID UNIQUEIDENTIFIER = NULL,
    @CourseName NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.course_id AS CourseID,
        c.course_code AS CourseCode,
        c.course_name AS CourseName,
        c.is_active AS IsActive,
        c.created_at AS CreatedAt,
        c.updated_at AS UpdatedAt,
        c.delete_flg AS DeleteFlg
    FROM Course c
    WHERE
        ISNULL(c.delete_flg, 0) = 0
        AND (@CourseID IS NULL OR c.course_id = @CourseID)
        AND (@CourseName IS NULL OR c.course_name LIKE '%' + @CourseName + '%')
    ORDER BY c.course_name
END
