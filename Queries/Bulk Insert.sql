--insert Data into Branch Table
BULK INSERT Branch
FROM 'D:\ITI\content\DataBase\Project\Data\Branch.csv'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '\n',    
    FIRSTROW = 2             
)

--insert Data into Course Table
BULK INSERT Course
FROM 'D:\ITI\content\DataBase\Project\Data\Course.csv'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '\n',    
    FIRSTROW = 2             
)

--insert Data into Student Table
BULK INSERT Student
FROM 'D:\ITI\content\DataBase\Project\Data\Student.csv'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '\n',    
    FIRSTROW = 2             
)

--insert Data into Track Table
BULK INSERT Track
FROM 'D:\ITI\content\DataBase\Project\Data\Track.csv'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '\n',    
    FIRSTROW = 2             
)

--insert Data into Instructor Table
BULK INSERT Instructor
FROM 'D:\ITI\content\DataBase\Project\Data\Instructor.csv'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '\n',    
    FIRSTROW = 2             
)

--insert Data into Department Table
BULK INSERT Department
FROM 'D:\ITI\content\DataBase\Project\Data\Department.csv'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '0x0a',    
    FIRSTROW = 2             
)

--insert Data into Intake Table
BULK INSERT Intake
FROM 'D:\ITI\content\DataBase\Project\Data\Intake.csv'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '0x0a',    
    FIRSTROW = 2             
)

--insert Data into Exam Table
BULK INSERT Exam
FROM 'D:\ITI\content\DataBase\Project\Data\Exam.csv'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '0x0a',    
    FIRSTROW = 2             
)

--insert Data into Instructor_Courses Table
BULK INSERT Instructor_Courses
FROM 'D:\ITI\content\DataBase\Project\Data\Ins_Courses.csv'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '0x0a',    
    FIRSTROW = 2             
)

--insert Data into Intake_Branch_Track Table
BULK INSERT Intake_Branch_Track
FROM 'D:\ITI\content\DataBase\Project\Data\Intake_Branch_Track.csv'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '0x0a',    
    FIRSTROW = 2             
)

--insert Data into Track_Courses Table
BULK INSERT Track_Courses
FROM 'D:\ITI\content\DataBase\Project\Data\Track_Courses.csv'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '0x0a',    
    FIRSTROW = 2             
)

--insert Data into Questions Table
BULK INSERT Questions
FROM 'D:\ITI\content\DataBase\Project\Data\Questions.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,         
    CODEPAGE = '65001',   
    TABLOCK
)

--insert Data into Exam_Question Table
BULK INSERT Exam_Question
FROM 'D:\ITI\content\DataBase\Project\Data\Exam_Question.csv'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '0x0a',    
    FIRSTROW = 2             
)

--insert Data into Exam_Student_Questions_Answers Table
BULK INSERT Exam_Student_Questions_Answers
FROM 'D:\ITI\content\DataBase\Project\Data\Exam_Student_Questions_Answers.csv'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '0x0a',    
    FIRSTROW = 2
)















