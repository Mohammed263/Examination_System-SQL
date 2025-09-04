
--(1)  Add    (Branch,Department,Track,Intack,Student,Instructor,Course)
--(2)  Edit   (Branch,Department,Track,Intack,Student,Instructor,Course)
--(3)  Remove (Branch,Department,Track,Intack,Student,Instructor,Course)
--(4)  Assign Instructor To Course
--(5)  Create Exam 
--(6)  Add Question To Exam (Randomly,Manually) 
--(7)  View Exam To Student
--(8)  Submit Student Answer
--(9)  Show Answer & Compare Submitted Answer With Correct Answer
--(10) Get Final Result For Student In Exam
--(11) Get Final Result For Instructor In His Course


-------------------------------------------------------------------------------------------------------

--Insert

------- SP To Add Branch -------
CREATE OR ALTER PROCEDURE Add_Branch @ID INT, @Name NVARCHAR(100)
AS
BEGIN TRY
    INSERT INTO Branch(ID, Name)
    VALUES (@ID, @Name)
END TRY
		--Raise Error if the user enters ID that already exists
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH



------- SP To Add Department -------
CREATE OR ALTER PROCEDURE Add_Department @ID INT, @Name NVARCHAR(100)
AS
BEGIN TRY
    INSERT INTO Department(ID, Name)
    VALUES (@ID, @Name)
END TRY
		--Raise Error if the user enters ID that already exists
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH



------- SP To Add Track -------
CREATE OR ALTER PROCEDURE Add_Track @ID INT, @Name NVARCHAR(100), @Dept_ID INT
AS
BEGIN TRY
    INSERT INTO Track(ID, Name, Dept_ID)
    VALUES (@ID, @Name, @Dept_ID)
END TRY
		--Raise Error if the user enters ID that already exists
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH



------- SP To Add Intack -------
CREATE OR ALTER PROCEDURE Add_Intake @ID INT, @Year INT, @Start_Date DATE, @End_Date DATE
AS
BEGIN TRY
    INSERT INTO Intake (ID, Year, Start_Date, End_Date)
    VALUES (@ID, @Year, @Start_Date, @End_Date)
END TRY
		--Raise Error if the user enters ID that already exists
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH



------- SP To Register Student -------
CREATE OR ALTER PROCEDURE Register_Student 
    @NID INT,
    @Full_Name NVARCHAR(MAX),
    @Gender NVARCHAR(1),
    @Birth_Date DATE,
    @Email NVARCHAR(100),
    @Phone NVARCHAR(20),
    @City NVARCHAR(50),
    @College NVARCHAR(50),
    @GPA FLOAT,
    @Grad_Year INT,
    @Track_ID INT,
    @Intake_ID INT,
    @Branch_ID INT
AS 
BEGIN TRY
    INSERT INTO Student
    (
        NID, Full_Name, Gender, Birth_Date, Email, Phone, City, 
        College, GPA, Grad_Year, Track_ID, Intake_ID, Branch_ID
    )
    VALUES
    (
        @NID, @Full_Name, @Gender, @Birth_Date, @Email, @Phone, @City, 
        @College, @GPA, @Grad_Year, @Track_ID, @Intake_ID, @Branch_ID
    )
END TRY
		--Raise Error if the user enters ID that already exists
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH



------- SP To Register Instructor -------
CREATE OR ALTER PROCEDURE Register_Instructor
    @NID INT,
    @Full_Name NVARCHAR(MAX),
    @Gender NVARCHAR(1),
    @Birth_Date DATE,
    @Phone NVARCHAR(20),
    @Email NVARCHAR(100),
    @City NVARCHAR(50),
    @Salary FLOAT,
    @Dept_ID INT
AS
BEGIN TRY
    INSERT INTO Instructor
    (
        NID, Full_Name, Gender, Birth_Date, Phone, Email, City, Salary, Dept_ID
    )
    VALUES
    (
        @NID, @Full_Name, @Gender, @Birth_Date, @Phone, @Email, @City, @Salary, @Dept_ID
    )
END TRY
		--Raise Error if the user enters ID that already exists
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH



------- SP To Register Course -------
CREATE OR ALTER PROCEDURE Register_Course
    @ID INT,
    @Name NVARCHAR(100),
    @Description NVARCHAR(MAX),
    @Min_Degree INT,
    @Max_Degree INT
AS
BEGIN TRY
		-- Check Constraint for Degrees 
    IF @Min_Degree >= @Max_Degree
    BEGIN
        RAISERROR('Error: Min_Degree must be less than Max_Degree.', 16, 1)
        RETURN
    END

    INSERT INTO Course
    (
        ID, Name, Description, Min_Degree, Max_Degree
    )
    VALUES
    (
        @ID, @Name, @Description, @Min_Degree, @Max_Degree
    )
END TRY
		--Raise Error if the user enters ID that already exists
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH


-------------------------------------------------------------------------------------------------------
--update

------- SP To Edit Branch -------
CREATE OR ALTER PROCEDURE Edit_Branch @ID INT, @Name NVARCHAR(100)
AS
BEGIN TRY
    UPDATE Branch
    SET Name = @Name
    WHERE ID = @ID

		--Raise Error if the user enters ID that does not exists
    IF @@ROWCOUNT = 0
        RAISERROR('Branch not found', 16, 1)
END TRY
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH


------- SP To Edit Department -------
CREATE OR ALTER PROCEDURE Edit_Department @ID INT, @Name NVARCHAR(100)
AS
BEGIN TRY
    UPDATE Department
    SET Name = @Name
    WHERE ID = @ID

		--Raise Error if the user enters ID that does not exists		
    IF @@ROWCOUNT = 0
        RAISERROR('Department not found', 16, 1)
END TRY
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH


------- SP To Edit Track -------
CREATE OR ALTER PROCEDURE Edit_Track @ID INT, @Name NVARCHAR(100), @Dept_ID INT
AS
BEGIN TRY
    UPDATE Track
    SET Name = @Name, Dept_ID = @Dept_ID
    WHERE ID = @ID

		--Raise Error if the user enters ID that does not exists
    IF @@ROWCOUNT = 0
        RAISERROR('Track not found', 16, 1)
END TRY
		--Raise Error if the user enters ID (foreign key) that does not match ID (primary key) in another table
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH


------- SP To Edit Intake -------
CREATE OR ALTER PROCEDURE Edit_Intake @ID INT, @Year INT, @Start_Date DATE, @End_Date DATE
AS
BEGIN TRY
    UPDATE Intake
    SET [Year] = @Year, Start_Date = @Start_Date, End_Date = @End_Date
    WHERE ID = @ID

		--Raise Error if the user enters ID that does not exists
    IF @@ROWCOUNT = 0
        RAISERROR('Intake not found', 16, 1)
END TRY
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH


------- SP To Edit Student -------
CREATE OR ALTER PROCEDURE Edit_Student
    @NID INT,
    @Full_Name NVARCHAR(MAX) = NULL,
    @Gender NVARCHAR(1) = NULL,
    @Birth_Date DATE = NULL,
    @Email NVARCHAR(100) = NULL,
    @Phone NVARCHAR(20) = NULL,
    @City NVARCHAR(50) = NULL,
    @College NVARCHAR(50) = NULL,
    @GPA FLOAT = NULL,
    @Grad_Year INT = NULL,
    @Track_ID INT = NULL,
    @Intake_ID INT = NULL,
    @Branch_ID INT = NULL
AS
BEGIN TRY
    UPDATE Student
    SET Full_Name = ISNULL(@Full_Name, Full_Name),
        Gender = ISNULL(@Gender, Gender),
        Birth_Date = ISNULL(@Birth_Date, Birth_Date),
        Email = ISNULL(@Email, Email),
        Phone = ISNULL(@Phone, Phone),
        City = ISNULL(@City, City),
        College = ISNULL(@College, College),
        GPA = ISNULL(@GPA, GPA),
        Grad_Year = ISNULL(@Grad_Year, Grad_Year),
        Track_ID = ISNULL(@Track_ID, Track_ID),
        Intake_ID = ISNULL(@Intake_ID, Intake_ID),
        Branch_ID = ISNULL(@Branch_ID, Branch_ID)
    WHERE NID = @NID

		--Raise Error if the user enters ID that does not exists
    IF @@ROWCOUNT = 0
        RAISERROR('Student not found', 16, 1)
END TRY
		--Raise Error if the user enters ID (foreign key) that does not match ID (primary key) in another table
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH



------- SP To Edit Instructor -------
CREATE OR ALTER PROCEDURE Edit_Instructor
    @NID INT,
    @Full_Name NVARCHAR(MAX) = NULL,
    @Gender NVARCHAR(1) = NULL,
    @Birth_Date DATE = NULL,
    @Phone NVARCHAR(20) = NULL,
    @Email NVARCHAR(100) = NULL,
    @City NVARCHAR(50) = NULL,
    @Salary DECIMAL(10,2) = NULL,
    @Dept_ID INT = NULL
AS
BEGIN TRY
    UPDATE Instructor
    SET Full_Name = ISNULL(@Full_Name, Full_Name),
        Gender = ISNULL(@Gender, Gender),
        Birth_Date = ISNULL(@Birth_Date, Birth_Date),
        Phone = ISNULL(@Phone, Phone),
        Email = ISNULL(@Email, Email),
        City = ISNULL(@City, City),
        Salary = ISNULL(@Salary, Salary),
        Dept_ID = ISNULL(@Dept_ID, Dept_ID)
    WHERE NID = @NID  

		--Raise Error if the user enters ID that does not exists
    IF @@ROWCOUNT = 0
        RAISERROR('Instructor not found', 16, 1)
END TRY
		--Raise Error if the user enters ID (foreign key) that does not match ID (primary key) in another table
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@ErrorMessage, 16, 1)
END CATCH



------- SP To Edit Course -------
CREATE OR ALTER PROCEDURE Edit_Course
    @ID INT,
    @Name NVARCHAR(100) = NULL,
    @Description NVARCHAR(MAX) = NULL,
    @Min_Degree INT = NULL,
    @Max_Degree INT = NULL
AS
BEGIN TRY
    -- Check Min < Max
    IF @Min_Degree IS NOT NULL AND @Max_Degree IS NOT NULL AND @Min_Degree >= @Max_Degree
    BEGIN
        RAISERROR('Error: Min_Degree must be less than Max_Degree.', 16, 1)
        RETURN
    END

    UPDATE Course
    SET Name = ISNULL(@Name, Name),
        Description = ISNULL(@Description, Description),
        Min_Degree = ISNULL(@Min_Degree, Min_Degree),
        Max_Degree = ISNULL(@Max_Degree, Max_Degree)
    WHERE ID = @ID  

   		--Raise Error if the user enters ID that does not exists
    IF @@ROWCOUNT = 0
        RAISERROR('Course not found', 16, 1)
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@ErrorMessage, 16, 1)
END CATCH


-------------------------------------------------------------------------------------------------------

--delete

------- SP To Remove Branch -------
CREATE OR ALTER PROCEDURE Remove_Branch @ID INT
AS
BEGIN TRY
    DELETE FROM Branch
    WHERE ID = @ID

		--Raise Error if the user enters ID that does not exists
    IF @@ROWCOUNT = 0
        RAISERROR('Branch not found', 16, 1)
END TRY
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH


------- SP To Remove Department -------
CREATE OR ALTER PROCEDURE Remove_Department @ID INT
AS
BEGIN TRY
    DELETE FROM Department
    WHERE ID = @ID

		--Raise Error if the user enters ID that does not exists
    IF @@ROWCOUNT = 0
        RAISERROR('Department not found', 16, 1)
END TRY
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH


------- SP To Remove Track -------
CREATE OR ALTER PROCEDURE Remove_Track @ID INT
AS
BEGIN TRY
    DELETE FROM Track
    WHERE ID = @ID

		--Raise Error if the user enters ID that does not exists
    IF @@ROWCOUNT = 0
        RAISERROR('Track not found', 16, 1)
END TRY
		--Raise Error if the user enters ID (foreign key) that does not match ID (primary key) in another table
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH


------- SP To Remove Intake -------
CREATE OR ALTER PROCEDURE Remove_Intake @ID INT
AS
BEGIN TRY
    DELETE FROM Intake
    WHERE ID = @ID

		--Raise Error if the user enters ID that does not exists
    IF @@ROWCOUNT = 0
        RAISERROR('Intake not found', 16, 1)
END TRY
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH


------- SP To Remove Student -------
CREATE OR ALTER PROCEDURE Remove_Student @NID INT
AS
BEGIN TRY

    DELETE FROM Student
    WHERE NID = @NID;

    -- Raise Error if the user enters ID that does not exist
    IF @@ROWCOUNT = 0
        RAISERROR('Student not found', 16, 1);
END TRY
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH



------- SP To Remove Instructor -------
CREATE OR ALTER PROCEDURE Remove_Instructor @NID INT
AS
BEGIN TRY

    DELETE FROM Instructor
    WHERE NID = @NID;

    -- Raise Error if the user enters ID that does not exist
    IF @@ROWCOUNT = 0
        RAISERROR('Instructor not found', 16, 1);
END TRY
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH



------- SP To Remove Course -------
CREATE OR ALTER PROCEDURE Remove_Course @ID INT
AS
BEGIN TRY

    DELETE FROM Course
    WHERE ID = @ID;

    -- Raise Error if the user enters ID that does not exist
    IF @@ROWCOUNT = 0
        RAISERROR('Course not found', 16, 1);
END TRY
BEGIN CATCH
    DECLARE @Error_Message NVARCHAR(MAX) = ERROR_MESSAGE()
    RAISERROR(@Error_Message, 16, 1)
END CATCH

-------------------------------------------------------------------------------------------------------

------- SP To Assign An Instructor To Course -------
CREATE OR ALTER PROCEDURE Assign_Course_To_Instructor
    @InstructorID INT,
    @CourseID INT
AS
BEGIN
    -- Check if this instructor is already assigned to the course in this intake
    IF EXISTS (
        SELECT 1
        FROM Instructor_Courses
        WHERE Instructor_ID = @InstructorID
          AND Course_ID = @CourseID
    )
    BEGIN
        PRINT 'This instructor is already assigned to this course in this intake.';
        RETURN;
    END;

    -- Insert the assignment
    INSERT INTO Instructor_Courses (Instructor_ID, Course_ID)
    VALUES (@InstructorID, @CourseID);

    PRINT 'Course assigned to instructor successfully.';
END;

-------------------------------------------------------------------------------------------------------

------- SP To Create An Exam -------
CREATE OR ALTER PROCEDURE Create_Exam
    @ID INT,
    @No_Question INT,
    @Type VARCHAR(50),
    @Date DATE,
    @Start_Time TIME,
    @End_Time TIME,
    @Total_Degree INT,
    @InstructorID INT,
    @CourseID INT,
    @IntakeID INT,
    @BranchID INT,
    @TrackID INT
AS
BEGIN
    -- VALIDATION: CHECK EXAM END TIME > START TIME
    IF @End_Time < @Start_Time
    BEGIN
        RAISERROR('END TIME MUST BE GREATER THAN START TIME.', 16, 1);
        RETURN;
    END;

    -- VALIDATION: CHECK THAT EXAM DEGREE DOES NOT EXCEED COURSE MAX_DEGREE
    DECLARE @MaxDegree INT;

    SELECT @MaxDegree = MAX_DEGREE
    FROM COURSE
    WHERE COURSE.ID = @CourseID;

    IF @Total_Degree > @MaxDegree
    BEGIN
        RAISERROR('TOTAL DEGREE EXCEEDS THE MAXIMUM ALLOWED DEGREE FOR THIS COURSE.', 16, 1);
        RETURN;
    END;

    -- VALIDATION: CHECK THAT INSTRUCTOR TEACHES THIS COURSE
    IF NOT EXISTS (
        SELECT 1
        FROM Instructor_Courses IC
        WHERE IC.Instructor_ID = @InstructorID
          AND IC.Course_ID = @CourseID
    )
    BEGIN
        RAISERROR('THIS INSTRUCTOR IS NOT ASSIGNED TO TEACH THIS COURSE.', 16, 1);
        RETURN;
    END;

    -- INSERT THE EXAM
    INSERT INTO EXAM (
        ID, NO_QUESTION, [TYPE], [DATE], START_TIME, END_TIME,
        TOTAL_DEGREE, INS_NID, COURSE_ID, INTAKE_ID, BRANCH_ID, TRACK_ID
    )
    VALUES (
        @ID, @No_Question, @Type, @Date, @Start_Time, @End_Time,
        @Total_Degree, @InstructorID, @CourseID, @IntakeID, @BranchID, @TrackID
    );

    PRINT 'EXAM CREATED SUCCESSFULLY.';
END;

-------------------------------------------------------------------------------------------------------

------- SP To  Add Questions To Exam Randomly -------
CREATE PROCEDURE Add_Questions_Randomly
    @ExamID INT,
    @NumberOfQuestions INT
AS
BEGIN
    DECLARE @CourseID INT;

    -- Get course ID of the exam
    SELECT @CourseID = course_id
    FROM Exam
    WHERE id = @ExamID;

    IF @CourseID IS NULL
    BEGIN
        RAISERROR('Invalid ExamID. Exam not found.', 16, 1);
        RETURN;
    END

    -- Insert random questions from the pool for this course
    INSERT INTO Exam_Question (exam_id, question_id)
    SELECT TOP (@NumberOfQuestions) @ExamID, q.id
    FROM Questions q
    WHERE q.course_id = @CourseID
      AND q.id NOT IN (
          SELECT Question_ID FROM Exam_Question WHERE exam_id = @ExamID
						) -- avoid duplicates
    ORDER BY NEWID()  -- SQL Server randomizer

    PRINT 'Random questions added successfully.';
END



------- SP To Add Question To Exam Manulally -------
CREATE or alter PROCEDURE Add_Questions_Manulally
    @ExamID INT,
    @QuestionID INT
AS
BEGIN

    DECLARE @CourseID_Exam INT, @CourseID_Question INT;

    -- Get the course of the exam
    SELECT @CourseID_Exam = course_id
    FROM Exam
    WHERE id = @ExamID;   

    IF @CourseID_Exam IS NULL
    BEGIN
        RAISERROR('Invalid ExamID. Exam not found.', 16, 1);
        RETURN;
    END

    -- Get the course of the question
    SELECT @CourseID_Question = course_id
    FROM Questions
    WHERE id = @QuestionID;  

    IF @CourseID_Question IS NULL
    BEGIN
        RAISERROR('Invalid QuestionID. Question not found.', 16, 1);
        RETURN;
    END

    -- Check if both belong to the same course
    IF @CourseID_Exam <> @CourseID_Question
    BEGIN
        RAISERROR('Course mismatch: Question does not belong to the same course as the exam.', 16, 1);
        RETURN;
    END

    -- Insert into ExamQuestions
    INSERT INTO Exam_Question (exam_id, question_id)
    VALUES (@ExamID, @QuestionID)

    PRINT 'Question successfully added to exam.';
END

-------------------------------------------------------------------------------------------------------

------- SP To View Exam -------
CREATE OR ALTER PROCEDURE View_Exam  
    @E_ID INT,  
    @Student_ID INT  
AS  
BEGIN  
    -- CHECK IF EXAM IS ASSIGNED TO THE STUDENT’S TRACK COURSES  
    IF NOT EXISTS (
    SELECT 1
    FROM Exam 
    JOIN Track ON Exam.Track_ID = Track.ID
    JOIN Student ON Student.Track_ID = Track.ID
    JOIN Track_Courses ON Track_Courses.Track_ID = Track.ID
    JOIN Course ON Course.ID = Track_Courses.Course_ID
    WHERE Exam.ID = @E_ID 
      AND Student.NID = @Student_ID
)

    BEGIN  
        RAISERROR('ACCESS DENIED: STUDENT NOT REGISTERED FOR THIS COURSE', 16, 1);  
        RETURN;  
    END;

    -- check exam date and time window (using separate columns)
    if not exists (
        select 1
        from exam e
        where e.id = @e_id
          and cast(getdate() as date) = e.date
          and cast(getdate() as time) between e.start_time and e.end_time
    )
    begin
        raiserror('access denied: exam is not available at this time', 16, 1);
        return;
    end;

    -- if corrective exam, check that student failed normal one
    if exists (
        select 1 from exam e where e.id = @e_id and e.type = 'corrective'
    )
    begin
        if not exists (
            select 1
            from exam e
            join Exam_Student_Questions_Answers es on es.Exam_id = e.ID
            where e.course_id = (select course_id from exam where id = @e_id)
              and e.type = 'normal'
              and es.student_id = @student_id
			  group by es.Exam_ID,e.ID,e.Total_Degree
              having sum(es.student_degree) < e.Total_Degree * 0.6
        )
        begin
            raiserror('access denied: student must fail normal exam before corrective one', 16, 1);
            return;
        end;
    end;

    -- if all conditions pass, show questions
    select q.id, q.head, q.options
    from questions q
    join exam_question eq on q.id = eq.question_id
    where eq.exam_id = @e_id;
end
-------------------------------------------------------------------------------------------------------

------- SP To Add Or Edit Student_Answer ------- (Text,MCQ,T/F)
CREATE OR ALTER PROCEDURE Submit_Answer  
    @Exam_ID INT,  
    @Student_ID INT,  
    @Question_ID INT,  
    @Answer VARCHAR(100)  
AS  
BEGIN  
    -- IF RECORD EXISTS, UPDATE IT  
    IF EXISTS (
        SELECT 1 
        FROM EXAM_STUDENT_QUESTIONS_ANSWERS
        WHERE EXAM_ID = @Exam_ID 
          AND STUDENT_ID = @Student_ID 
          AND QUESTION_ID = @Question_ID
    )  
    BEGIN  
        UPDATE EXAM_STUDENT_QUESTIONS_ANSWERS  
        SET STUDENT_ANSWER = @Answer,  
        IS_CORRECT = CASE 
			WHEN Q.Type IN ('Multiple choice', 'True/False') 
				THEN CASE WHEN @Answer = Q.CORRECT_ANSWER	
					THEN 'TRUE' ELSE 'FALSE' END
			WHEN Q.Type = 'Text' 
				THEN CASE WHEN dbo.Levenshtein_Similarity(@Answer, Q.CORRECT_ANSWER) >= 0.8 
					THEN 'TRUE' ELSE 'FALSE' END
			END,
            STUDENT_DEGREE = CASE 
			WHEN Q.Type IN ('Multiple choice', 'True/False') 
				THEN CASE WHEN @Answer = Q.CORRECT_ANSWER THEN 5 ELSE 0 END
			WHEN Q.Type = 'Text' 
				THEN CASE WHEN dbo.Levenshtein_Similarity(@Answer, Q.CORRECT_ANSWER) >= 0.8 THEN 5 ELSE 0 END
    END  
        FROM QUESTIONS Q  
        WHERE EXAM_STUDENT_QUESTIONS_ANSWERS.QUESTION_ID = Q.ID  
          AND EXAM_STUDENT_QUESTIONS_ANSWERS.EXAM_ID = @Exam_ID  
          AND EXAM_STUDENT_QUESTIONS_ANSWERS.STUDENT_ID = @Student_ID  
          AND EXAM_STUDENT_QUESTIONS_ANSWERS.QUESTION_ID = @Question_ID;  
    END  
    ELSE  
    BEGIN  
        -- IF NOT EXISTS, INSERT NEW RECORD  
        INSERT INTO EXAM_STUDENT_QUESTIONS_ANSWERS  
            (EXAM_ID, STUDENT_ID, QUESTION_ID, STUDENT_ANSWER, IS_CORRECT, STUDENT_DEGREE)  
        SELECT  
            @Exam_ID,  
            @Student_ID,  
            @Question_ID,  
            @Answer,

			--Check the question type
            CASE 
			WHEN Q.Type IN ('Multiple choice', 'True/False') 
				THEN 
				CASE WHEN @Answer = Q.CORRECT_ANSWER THEN 'TRUE' ELSE 'FALSE' END
			WHEN Q.Type = 'Text' 
				THEN 
				CASE WHEN dbo.Levenshtein_Similarity(@Answer,Q.CORRECT_ANSWER)>= 0.8 THEN 'TRUE' ELSE 'FALSE' END
			END
			,
			CASE 
			WHEN Q.Type IN ('Multiple choice', 'True/False') 
				THEN CASE WHEN @Answer = Q.CORRECT_ANSWER THEN 5 ELSE 0 END
			WHEN Q.Type = 'Text' 
			    THEN CASE WHEN dbo.Levenshtein_Similarity(@Answer, Q.CORRECT_ANSWER) >= 0.8 THEN 5 ELSE 0 END
			END  
        FROM QUESTIONS Q  
        WHERE Q.ID = @Question_ID;  
    END  
END;

-------------------------------------------------------------------------------------------------------

------- SP To Compare Submitted Answers With Correct Answers -------
CREATE OR ALTER PROCEDURE Compare_Answer 
    @Student_ID INT,  
    @Exam_ID INT  
AS  
BEGIN  
    SELECT  
        ESQA.Exam_ID,  
        ESQA.Student_ID,  
        S.Full_Name,  
        Q.Head AS Question,  
        ESQA.Student_Answer,  
        Q.Correct_Answer,  
        ESQA.IS_Correct  
    FROM EXAM_STUDENT_QUESTIONS_ANSWERS ESQA  
    JOIN STUDENT S  
        ON ESQA.Student_ID = S.NID  
    JOIN QUESTIONS Q  
        ON Q.ID = ESQA.Question_ID  
    WHERE ESQA.Student_ID = @Student_ID  
      AND ESQA.Exam_ID = @Exam_ID;  

    -- TO SHOW STUDENT'S ANSWERS TO EACH QUESTION AND THE QUESTION'S CORRECT ANSWERS  
END;

-------------------------------------------------------------------------------------------------------

------- SP To Get Final Result For Student In Exam -------
CREATE OR ALTER PROCEDURE Calculate_Result  
    @Student_ID INT,  
    @Exam_ID INT  
AS  
BEGIN  
    DECLARE @Degree INT;  

    SELECT @Degree = ISNULL(SUM(Student_Degree), 0)  
    FROM EXAM_STUDENT_QUESTIONS_ANSWERS ESQA  
    JOIN QUESTIONS Q  
        ON ESQA.Question_ID = Q.ID  
    WHERE ESQA.Student_ID = @Student_ID  
      AND ESQA.Exam_ID = @Exam_ID  
      AND ESQA.Student_Answer = Q.Correct_Answer;  
    -- TO CALCULATE SCORE AFTER COMPARING THE SUBMITTED ANSWERS WITH CORRECT ANSWERS  

    SELECT @Student_ID AS Student_ID,  
           @Exam_ID AS Exam_ID,  
           @Degree AS Score;  
END;

-------------------------------------------------------------------------------------------------------

------- SP To Get Final Result For Instructor In His Course -------
CREATE OR ALTER PROCEDURE Course_Result  
    @Instructor_ID INT,  
    @Course_ID INT  
AS  
BEGIN  
    IF NOT EXISTS (  
        SELECT 1   
        FROM INSTRUCTOR_COURSES IC  
        WHERE IC.Instructor_ID = @Instructor_ID   
          AND IC.Course_ID = @Course_ID  
    )  
    BEGIN  
        RAISERROR('ACCESS DENIED: Instructor not assigned to this course.', 16, 1);  
        RETURN;  
    END;  

    SELECT S.NID AS [Student ID],  
           S.Full_Name AS [Student Name],  
           E.Type AS [Exam Type],  
           E.ID AS [Exam ID],  
           C.Name AS [Course Name],  
           SUM(ESQA.Student_Degree) AS [Total Degree]  
    FROM STUDENT S   
    JOIN EXAM_STUDENT_QUESTIONS_ANSWERS ESQA   
        ON S.NID = ESQA.Student_ID   
    JOIN EXAM E  
        ON E.ID = ESQA.Exam_ID  
    JOIN COURSE C  
        ON C.ID = E.Course_ID  
    JOIN INSTRUCTOR_COURSES IC  
        ON IC.Course_ID = C.ID  

    WHERE IC.Instructor_ID = @Instructor_ID  
      AND IC.Course_ID = @Course_ID  

    GROUP BY S.NID, S.Full_Name, E.ID, E.Type, C.Name;  
END;

-------------------------------------------------------------------------------------------------------






