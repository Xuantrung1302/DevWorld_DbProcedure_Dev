CREATE or alter PROCEDURE SP_GetChatContactsByUserID
    @CurrentUserID VARCHAR(10)
AS
BEGIN
    -- Tạm lưu tất cả ID đã từng chat với người hiện tại (distinct)
    SELECT DISTINCT
        CASE 
            WHEN SenderID = @CurrentUserID THEN ReceiverID
            WHEN ReceiverID = @CurrentUserID THEN SenderID
        END AS ContactID	
    INTO #Contacts
    FROM Messages
    WHERE SenderID = @CurrentUserID OR ReceiverID = @CurrentUserID;

    -- Trả kết quả: ID và FullName (dựa vào tiền tố mã)
    SELECT 
        C.ContactID AS ID,
        CASE 
            WHEN LEFT(C.ContactID, 2) = 'HV' THEN S.FullName
            WHEN LEFT(C.ContactID, 2) = 'GV' THEN T.FullName
            WHEN LEFT(C.ContactID, 2) = 'NV' THEN E.FullName
            ELSE N'Không xác định'
        END AS FullName
    FROM #Contacts C
    LEFT JOIN Student S ON C.ContactID = S.StudentID
    LEFT JOIN Teacher T ON C.ContactID = T.TeacherID
    LEFT JOIN Employee E ON C.ContactID = E.EmployeeID

    DROP TABLE #Contacts
END

--exec SP_GetChatContactsByUserID 'nv001'
