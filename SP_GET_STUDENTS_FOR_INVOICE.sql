CREATE OR ALTER PROCEDURE [dbo].[SP_GET_STUDENTS_FOR_INVOICE]
    @StudentID VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        s.StudentID, 
        s.FullName
    FROM STUDENT s
    WHERE s.DELETE_FLG = 0 -- nếu có cột xóa mềm
      AND (
            @StudentID IS NULL OR 
            s.StudentID LIKE '%' + @StudentID + '%'
          )
    ORDER BY s.StudentID
END

--exec SP_GET_STUDENTS_FOR_INVOICE 'HV001'
