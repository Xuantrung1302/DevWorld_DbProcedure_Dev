USE [DEV_ACADEMY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_INSERT_CLASS_ENROLLMENT]
    @StudentID VARCHAR(10),
    @ClassID UNIQUEIDENTIFIER,
    @EnrollmentDate DATETIME = NULL,
    @ApprovedBy VARCHAR(10) = NULL,
    @ApprovalDate DATETIME = NULL,
    @CompletionStatus NVARCHAR(20) = NULL,
    @CompletionDate DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert vào CLASS_ENROLLMENT
        INSERT INTO CLASS_ENROLLMENT
        (
            EnrollmentID,
            StudentID,
            ClassID,
            EnrollmentDate,
            ApprovedBy,
            ApprovalDate,
            CompletionStatus,
            CompletionDate
        )
        VALUES
        (
            NEWID(),
            @StudentID,
            @ClassID,
            ISNULL(@EnrollmentDate, GETDATE()),
            @ApprovedBy,
            @ApprovalDate,
            @CompletionStatus,
            @CompletionDate
        );

        UPDATE CLASS
        SET StudentCount = 
        (
            SELECT COUNT(*)
            FROM CLASS_ENROLLMENT CE
            WHERE CE.ClassID = @ClassID
        )
        WHERE ClassID = @ClassID;

        COMMIT TRANSACTION;
        RETURN 1; -- Success
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Error NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Error, 16, 1);
        RETURN 0; -- Failure
    END CATCH
END
GO
