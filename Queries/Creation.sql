CREATE DATABASE [ExaminationSystem]
ON PRIMARY
(
    NAME = N'ExaminationSystem_data',
    FILENAME = N'D:\ITI\9- Advanced SQL Server Programming\Project\Database\ExaminationSystem_data.mdf',
    SIZE =50MB,
    FILEGROWTH = 10MB
),
FILEGROUP ExamData
(
    NAME = N'exam_data',
    FILENAME = N'D:\ITI\9- Advanced SQL Server Programming\Project\Database\exam_data.ndf',
    SIZE = 50MB,
    FILEGROWTH = 10MB
)
LOG ON
(
    NAME = N'ExaminationSystem_log',
    FILENAME = N'D:\ITI\9- Advanced SQL Server Programming\Project\Database\ExaminationSystem_log.ldf',
    SIZE = 10MB,
    FILEGROWTH = 5MB
)

use ExaminationSystem

--create departement table 
CREATE TABLE Department (       
    ID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
)

--create track table
CREATE TABLE Track (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100) ,
    Dept_ID INT ,
    FOREIGN KEY (Dept_ID) REFERENCES Department(ID)
)

--create branch table
CREATE TABLE Branch (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100) 
)

--create intake table
CREATE TABLE Intake (
    ID INT PRIMARY KEY,
    Year INT ,
    Start_Date DATE ,
    End_Date DATE 
)

--create course table
CREATE TABLE Course (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100) ,
    Description NVARCHAR(MAX),
     Min_Degree INT,
	 Max_Degree INT 
)

--create student table
CREATE TABLE Student (
    NID INT PRIMARY KEY,                  
    Full_Name NVARCHAR(MAX),              
    Gender NVARCHAR(1),                   
    Birth_Date DATE,
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    City NVARCHAR(50),
    College NVARCHAR(50),
    GPA FLOAT,
    Grad_Year INT,
    Track_ID INT,
    Intake_ID INT,
    Branch_ID INT,
    FOREIGN KEY (Track_ID) REFERENCES Track(ID),
     FOREIGN KEY (Intake_ID) REFERENCES Intake(ID),
     FOREIGN KEY (Branch_ID) REFERENCES Branch(ID)
)

--create instructor table
CREATE TABLE Instructor (
    NID INT PRIMARY KEY,
    Full_Name NVARCHAR(max),
    Gender NVARCHAR(1),
    Birth_Date DATE,
    Phone NVARCHAR(20),
    Email NVARCHAR(100),
    City NVARCHAR(50),
    Salary float,
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(ID)
)

--create exam table
CREATE TABLE Exam (
    ID INT PRIMARY KEY,
    No_Question INT,
    Type NVARCHAR(50),
    Date DATE,
    Start_Time TIME,
    End_Time Time,
    Allowance_Options NVARCHAR(max),
    Total_Degree INT,
    Ins_NID INT ,
    Course_ID INT ,
    FOREIGN KEY (Ins_NID) REFERENCES Instructor(NID),
    FOREIGN KEY (Course_ID) REFERENCES Course(ID)
) on ExamData
CREATE TABLE Exam (
    ID INT PRIMARY KEY,
    No_Question INT,
    Type NVARCHAR(50),
    Date DATE,
    Start_Time TIME,
    End_Time TIME,
    Total_Degree INT,
    Ins_NID INT,
    Course_ID INT,
    Intake_ID INT,
    Branch_ID INT,
    Track_ID INT,
    FOREIGN KEY (Ins_NID) REFERENCES Instructor(NID),
    FOREIGN KEY (Course_ID) REFERENCES Course(ID),
    FOREIGN KEY (Intake_ID) REFERENCES Intake(ID),
    FOREIGN KEY (Branch_ID) REFERENCES Branch(ID),
    FOREIGN KEY (Track_ID) REFERENCES Track(ID)
) ON ExamData

--create questions table
CREATE TABLE Questions (
    ID INT PRIMARY KEY,
    Head NVARCHAR(MAX),
    Options NVARCHAR(MAX),
    Type NVARCHAR(50),
    Correct_Answer NVARCHAR(MAX),
    Degree INT,
    Course_ID INT,
    FOREIGN KEY (Course_ID) REFERENCES Course(ID)
)on ExamData

--create Exam_Question table (many-many)
CREATE TABLE Exam_Question (
    Exam_ID INT,
    Question_ID INT,
    PRIMARY KEY (Exam_ID, Question_ID),
    FOREIGN KEY (Exam_ID) REFERENCES Exam(ID),
    FOREIGN KEY (Question_ID) REFERENCES Questions(ID)
)on ExamData

--create Exam_Student_Questions_Answers table
CREATE TABLE Exam_Student_Questions_Answers (
    Exam_ID INT,
    Student_ID INT,
    Question_ID INT,
    Student_Answer NVARCHAR(MAX),
    IS_Correct BIT,
	Student_Degree INT
    PRIMARY KEY (Exam_ID, Student_ID, Question_ID),
    FOREIGN KEY (Exam_ID) REFERENCES Exam(ID),
    FOREIGN KEY (Student_ID) REFERENCES Student(NID),
    FOREIGN KEY (Question_ID) REFERENCES Questions(ID)
)on ExamData

ALTER TABLE Exam_Student_Questions_Answers
ALTER COLUMN IS_Correct NVARCHAR(10)

--create Instructor_Courses table
CREATE TABLE Instructor_Courses (
    Instructor_ID INT,
    Course_ID INT,
    PRIMARY KEY (Instructor_ID, Course_ID),
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(NID),
    FOREIGN KEY (Course_ID) REFERENCES Course(ID)
)

--create Track_Courses table
CREATE TABLE Track_Courses (
    Track_ID INT,
    Course_ID INT,
    PRIMARY KEY (Track_ID, Course_ID),
    FOREIGN KEY (Track_ID) REFERENCES Track(ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(ID)
)

--create Intake_Branch_Track table
CREATE TABLE Intake_Branch_Track (
    Intake_ID INT,
    Branch_ID INT,
    Track_ID INT,
    PRIMARY KEY (Intake_ID, Branch_ID, Track_ID),
    FOREIGN KEY (Intake_ID) REFERENCES Intake(ID),
    FOREIGN KEY (Branch_ID) REFERENCES Branch(ID),
    FOREIGN KEY (Track_ID) REFERENCES Track(ID)
)
 