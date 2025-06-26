
-- Chức năng: tính số học phí của sinh viên theo kì

alter PROCEDURE SP_CalculateTuitionBySemester
    @StudentID VARCHAR(10),
    @SemesterID VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        @StudentID AS StudentID,
        @SemesterID AS SemesterID,
        SUM(C.TuitionFee) AS TotalTuitionFee
    FROM [dbo].[ENROLLMENT] E
    JOIN [dbo].[CLASS] C ON E.ClassID = C.ClassID
    WHERE E.StudentID = @StudentID
    AND C.SemesterID = @SemesterID
    GROUP BY C.SemesterID
    HAVING SUM(C.TuitionFee) IS NOT NULL; -- Chỉ trả về nếu có học phí

    RETURN 0;
END;
GO


--EXEC SP_CalculateTuitionBySemester 'HV24010207', 'KY2403'

--go
--select * from INVOICE
--where StudentID = 'HV24010207'

--go
--SELECT * FROM STUDENT

--GO
--SELECT * FROM SEMESTER

--select * from REGISTRATIONFORM
--where StudentID = 'HV24010207'


--PG240007	HV24010207	2024-07-01	Đăng ký khóa Lập trình Python Cơ bản

--select * from ENROLLMENT
--where StudentID = 'HV24010207'

--select * from ENROLLMENT
--where StudentID = 'HV24010207'

--select * from SEMESTER

--insert into ENROLLMENT(EnrollmentID, StudentId, ClassID, EnrollmentDate) 
--values('DK240043', 'HV24010207', 'LH240104', '2024-01-01')

--go

--insert into REGISTRATIONFORM(FormID, StudentId, RegistrationDate, Notes) 
--values('PG240042', 'HV24010207', '2024-04-01', 'Đăng kí học kì 2')

--go



--LH240102	2024-07-01
--JavaScript Nâng cao 1
--select * from CLASS
--where ClassID = 'LH240101'


