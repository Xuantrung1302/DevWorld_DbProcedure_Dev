USE [DEV_ACADEMY]
GO
/****** Object:  StoredProcedure [dbo].[SP_AutoGenerateId]    Script Date: 02/07/2025 22:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_AutoGenerateId]
    @NgayBD DATE,
    @Prefix NVARCHAR(2),  
    @NewID NVARCHAR(10) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @BasePrefix NVARCHAR(8) = @Prefix + FORMAT(@NgayBD, 'yyMMdd');
    DECLARE @MaxNumber INT = 0;

    IF @Prefix = 'HV'
    BEGIN
        SELECT @MaxNumber = ISNULL(MAX(CAST(SUBSTRING(StudentID, LEN(@BasePrefix)+1, 2) AS INT)), 0)
        FROM STUDENT
        WHERE StudentID LIKE @BasePrefix + '%';

        SET @MaxNumber = @MaxNumber + 1;

        WHILE EXISTS (SELECT 1 FROM STUDENT WHERE StudentID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber AS NVARCHAR), 2))
        BEGIN
            SET @MaxNumber = @MaxNumber + 1;
        END

        SET @NewID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber AS NVARCHAR), 2);
    END
    ELSE IF @Prefix = 'GV'
    BEGIN
        SELECT @MaxNumber = ISNULL(MAX(CAST(SUBSTRING(TeacherID, LEN(@BasePrefix)+1, 2) AS INT)), 0)
        FROM TEACHER
        WHERE TeacherID LIKE @BasePrefix + '%';

        SET @MaxNumber = @MaxNumber + 1;

        WHILE EXISTS (SELECT 1 FROM TEACHER WHERE TeacherID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber AS NVARCHAR), 2))
        BEGIN
            SET @MaxNumber = @MaxNumber + 1;
        END

        SET @NewID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber AS NVARCHAR), 2);
    END
    ELSE IF @Prefix = 'NV'
    BEGIN
        SELECT @MaxNumber = ISNULL(MAX(CAST(SUBSTRING(EmployeeID, LEN(@BasePrefix)+1, 2) AS INT)), 0)
        FROM EMPLOYEE
        WHERE EmployeeID LIKE @BasePrefix + '%';

        SET @MaxNumber = @MaxNumber + 1;

        WHILE EXISTS (SELECT 1 FROM EMPLOYEE WHERE EmployeeID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber AS NVARCHAR), 2))
        BEGIN
            SET @MaxNumber = @MaxNumber + 1;
        END

        SET @NewID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber AS NVARCHAR), 2);
    END
    ELSE IF @Prefix = 'MH'
    BEGIN
        SELECT @MaxNumber = ISNULL(MAX(CAST(SUBSTRING(SubjectID, LEN(@BasePrefix)+1, 2) AS INT)), 0)
        FROM SUBJECT
        WHERE SubjectID LIKE @BasePrefix + '%';

        SET @MaxNumber = @MaxNumber + 1;

        WHILE EXISTS (SELECT 1 FROM SUBJECT WHERE SubjectID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber AS NVARCHAR), 2))
        BEGIN
            SET @MaxNumber = @MaxNumber + 1;
        END

        SET @NewID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber AS NVARCHAR), 2);
    END
    ELSE IF @Prefix = 'HD'
    BEGIN
        SELECT @MaxNumber = ISNULL(MAX(CAST(SUBSTRING(InvoiceID, LEN(@BasePrefix)+1, 2) AS INT)), 0)
        FROM INVOICE
        WHERE InvoiceID LIKE @BasePrefix + '%';

        SET @MaxNumber = @MaxNumber + 1;

        WHILE EXISTS (SELECT 1 FROM INVOICE WHERE InvoiceID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber AS NVARCHAR), 2))
        BEGIN
            SET @MaxNumber = @MaxNumber + 1;
        END

        SET @NewID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber AS NVARCHAR), 2);
    END
    ELSE IF @Prefix = 'TT'
    BEGIN
        SELECT @MaxNumber = ISNULL(MAX(CAST(SUBSTRING(NewsID, LEN(@BasePrefix)+1, 2) AS INT)), 0)
        FROM NEWSBOARD
        WHERE NewsID LIKE @BasePrefix + '%';

        SET @MaxNumber = @MaxNumber + 1;

        WHILE EXISTS (SELECT 1 FROM NEWSBOARD WHERE NewsID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber AS NVARCHAR), 2))
        BEGIN
            SET @MaxNumber = @MaxNumber + 1;
        END

        SET @NewID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber AS NVARCHAR), 2);
    END
    ELSE IF @Prefix = 'KH'
    BEGIN
        SELECT @MaxNumber = ISNULL(MAX(CAST(SUBSTRING(SemesterID, LEN(@BasePrefix)+1, 2) AS INT)), 0)
        FROM SEMESTER
        WHERE SemesterID LIKE @BasePrefix + '%';

        SET @MaxNumber = @MaxNumber + 1;

        WHILE EXISTS (SELECT 1 FROM SEMESTER WHERE SemesterID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber AS NVARCHAR), 2))
        BEGIN
            SET @MaxNumber = @MaxNumber + 1;
        END

        SET @NewID = @BasePrefix + RIGHT('00' + CAST(@MaxNumber AS NVARCHAR), 2);
    END
END

--DECLARE @ID NVARCHAR(10);

--EXEC SP_AutoGenerateId '2025-07-02', 'HV', @ID OUTPUT;
--SELECT @ID AS NewStudentID;
