
--(1)  Track_Info (intake,department,branch,track)
--(2)  Student_Info (student,intake,branch,track   
--(3)  Instructor_Info (instructor,course)
--(4)  Student_Results (student,exam,course,degree)
--(5)  Create Exam_Statistics (exam,highest score,lowest score,average score)



--create view to show the tracks in each branchs in each intakes

create or alter view Track_Info 
AS
(
select Intake.Year,Department.Name as 'Department Name',Branch.Name as 'Branch Name',Track.Name as 'Track Name'
from Intake_Branch_Track 
join Intake on Intake.ID=Intake_ID
join Branch on Branch.ID=Branch_ID
join Track on track.ID=Track_ID
join Department on Department.ID=Track.Dept_ID
)

select * from Track_Info

--------------------------------------

--create view to show the student with the intake,branch and track he enrolled in 

create or alter view Student_Info
AS
(
select Student.Full_Name,Intake.Year,Branch.Name as 'Branch Name',Track.Name as 'Track Name'
from Student 
join Intake on Student.Intake_ID=Intake.ID
join Branch on Student.Branch_ID=Branch.ID
join Track on Student.Track_ID=Track.ID
)

select * from Student_Info

--------------------------------------

--create view  to show the instructor with the courses he teaches

create or alter view Instructor_Info
AS
(
select Instructor.Full_Name,Course.Name as 'Course Name',Course.Description,Course.Min_Degree,Course.Max_Degree
from Instructor_Courses
join Instructor on Instructor.NID=Instructor_ID
join Course on Course.ID=Course_ID
)

select * from Instructor_Info

--------------------------------------

--- View of Student Results of All Exams ---

create or alter view Student_Results
AS
(
select distinct  s.NID as 'Student_NID', s.Full_Name as 'Student_Name', e.ID as 'Exam_ID', e.Type as 'Exam_Type', c.Name as 'Course_Name',
                e.Date as 'Exam_Date' ,  e.Total_Degree 
from Student s
join Exam_Student_Questions_Answers esqa
    on s.NID = esqa.Student_ID
join Exam e
    on esqa.Exam_ID = e.ID
join Course c
    on e.Course_ID = c.ID
)

select * from Student_Results

---------------------------------------------------------------------------------------------------

--- View Exams Statistics ---


create or alter view Exam_Statistics
as
(
select e.ID as Exam_ID, e.Type as Exam_Type, e.Date as Exam_Date, 
	   count(ss.Student_ID) as No_Students,
	   max(ss.Total_Score) as Highest_Score,
	   min(ss.Total_Score) as Lowest_Score,
	   avg(ss.Total_Score) as Average_Score
from exam e
join
(SELECT Exam_ID, Student_ID, SUM(Student_Degree) AS Total_Score
FROM Exam_Student_Questions_Answers
GROUP BY Exam_ID, Student_ID) ss
on e.ID = ss.Exam_ID
group by e.ID, e.Type, e.Date
)

select * from Exam_Statistics
