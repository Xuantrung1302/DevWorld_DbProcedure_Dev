CREATE PROCEDURE sp_StatisticsDashboard
(
	@Year INT
)

AS
BEGIN
    -- Panel 1: Tổng số học viên
    SELECT COUNT(*) AS TotalStudents FROM Student;

    -- Panel 2: Tổng số giảng viên
    SELECT COUNT(*) AS TotalTeachers FROM Teacher;

    -- Panel 3: Tổng số nhân viên
    SELECT COUNT(*) AS TotalEmployees FROM Employee;

    -- Panel 4: Tổng số khóa học
    SELECT COUNT(*) AS TotalCourses FROM Course;

    ----------------------------------------------------
    -- Chart 2: Số học viên tham gia theo tháng (EnrollmentDate)

    SELECT 
    MONTH(EnrollmentDate) AS [Month],
    YEAR(EnrollmentDate) AS [Year],
    COUNT(StudentId) AS TotalEnrollments
	FROM CLASS_ENROLLMENT
	WHERE YEAR(EnrollmentDate) = @Year
	GROUP BY YEAR(EnrollmentDate), MONTH(EnrollmentDate)
	ORDER BY [Year], [Month];


    ----------------------------------------------------
    -- Chart 3: Doanh thu theo khóa học (Top 5)
      SELECT top 5
    c.course_id,
    c.course_name,
    SUM(i.Amount) AS TotalRevenue
	FROM INVOICE i
	JOIN Course c ON i.course_id = c.course_id
	WHERE i.DELETE_FLG = 0
	GROUP BY c.course_id, c.course_name
	ORDER BY TotalRevenue DESC;

    ----------------------------------------------------
    -- Chart 1: Thu - Chi theo tháng
    -- Thu: Tổng Invoice theo DueDate
    SELECT 
        YEAR(DueDate) AS Year,
        MONTH(DueDate) AS Month,
        SUM(Amount) AS TotalIncome
    FROM Invoice
    GROUP BY YEAR(DueDate), MONTH(DueDate)
    ORDER BY Year, Month;


	select * from Payroll
    -- Chi: Lương nhân viên và giảng viên
    -- Employees
    SELECT 
        YEAR(p.PayrollDate) AS Year,
        MONTH(p.PayrollDate) AS Month,
        SUM(p.WorkDays * e.BaseSalary) AS EmployeeSalaryCost
    FROM Payroll p
    INNER JOIN Employee e ON p.EmployeeId = e.EmployeeId
    GROUP BY YEAR(p.PayrollDate), MONTH(p.PayrollDate)
    ORDER BY Year, Month;

    -- Teachers
    SELECT 
        YEAR(p.PayrollDate) AS Year,
        MONTH(p.PayrollDate) AS Month,
        SUM(p.TeachingHours * t.HourlyRate) AS TeacherSalaryCost
    FROM Payrolls p
    INNER JOIN Teachers t ON p.TeacherId = t.TeacherId
    GROUP BY YEAR(p.PayrollDate), MONTH(p.PayrollDate)
    ORDER BY Year, Month;

END;
