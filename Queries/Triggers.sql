
--Trigger To Update The Total Degree 

CREATE or alter TRIGGER trg_UpdateExamTotalDegree
ON Exam_Question
AFTER INSERT, DELETE
AS
BEGIN

  -- Update only exams affected by this insert/delete
    UPDATE Exam 
    SET total_degree = (
        SELECT ISNULL(SUM(q.degree), 0)
        FROM Exam_Question eq
        JOIN Questions q ON eq.question_id = q.id
        WHERE eq.exam_id = Exam.id
    )
    FROM Exam 
    WHERE Exam.id IN (
        SELECT DISTINCT exam_id FROM inserted
        UNION
        SELECT DISTINCT exam_id FROM deleted
    )
END


-------------------------------------------------------------------------------------------------


--Trigger To Update The Number Of Exam Questions When Add New Questions To Exam

CREATE TRIGGER trg_UpdateExamQuestionCount
ON Exam_Question
AFTER INSERT, DELETE
AS
BEGIN

    -- Update only exams affected by this insert/delete
    UPDATE EXAM 
    SET no_question = (
        SELECT COUNT(*)
        FROM Exam_Question eq
        WHERE eq.exam_id = e.id
    )
    FROM Exam e
    WHERE e.id IN (
        SELECT DISTINCT exam_id FROM inserted
        UNION
        SELECT DISTINCT exam_id FROM deleted
    )
END

-------------------------------------------------------------------------------------------------

-- Trigger To Handle The Time Of Submit Answers

CREATE OR ALTER TRIGGER TRG_SUBMITANSWER
ON Exam_Student_Questions_Answers
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM INSERTED I
        JOIN Exam E ON E.ID = I.Exam_ID
        WHERE NOT (
            CAST(GETDATE() AS DATE) = E.Date
            AND CAST(GETDATE() AS TIME) BETWEEN E.Start_Time AND E.End_Time
        )
    )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('YOU CANNOT SUBMIT OR UPDATE ANSWERS OUTSIDE THE EXAM TIME WINDOW.', 16, 1);
    END
END;