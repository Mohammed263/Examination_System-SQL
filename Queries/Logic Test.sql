-- student ---> intake
select Full_Name,Year
from student join Intake
on Student.Intake_ID=Intake.ID

--student ---> course
select Student.Full_Name,count(Course.Name)
from Student join Track
on Student.Track_ID=Track.ID
join Track_Courses
on Track.ID=Track_Courses.Track_ID
join Course
on Course.ID=Track_Courses.Course_ID
group by Student.Full_Name

--student ---> exam he take
select  count(distinct Exam_ID),Student_ID,Student.Full_Name
from Exam_Student_Questions_Answers join Student
on Student.NID=Exam_Student_Questions_Answers.Student_ID
group by Student_ID ,Student.Full_Name

--student ---> total marks in exam
select sum(Exam_Student_Questions_Answers.Student_Degree),Student.Full_Name,
Exam_Student_Questions_Answers.Exam_ID
from Student join Exam_Student_Questions_Answers
on Student.NID=Exam_Student_Questions_Answers.Student_ID
group by Student.Full_Name,Exam_Student_Questions_Answers.Exam_ID

--instructor ---> intake
select distinct(Instructor.Full_Name),Intake.Year 
from Instructor join Department
on Instructor.Dept_ID=Department.ID
join Track
on Track.Dept_ID=Department.ID
join Intake_Branch_Track
on Intake_Branch_Track.Track_ID=Track.ID
join Intake
on Intake.ID=Intake_Branch_Track.Intake_ID
where Instructor.Full_Name='Sara Mahmoud'


--instructor ---> select questions
SELECT TOP 10 Head,Options,NEWID()
FROM Questions join course
on Questions.Course_ID=Course.ID
where Course.Name='Database Systems'
ORDER BY NEWID()


--exam ---> instructor
select Exam.ID,Instructor.Full_Name
from instructor right outer join Exam
on Instructor.NID=Exam.Ins_NID

--exam --->intake
select Exam.ID,Intake.Year from exam join Intake
on Intake.ID=Exam.Intake_ID




