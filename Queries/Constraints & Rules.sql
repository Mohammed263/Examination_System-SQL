-------------------------Constraints--------------------------

-- Creating Constraint on GPA --
Alter table Student
Add Constraint G
check ((GPA) BETWEEN 2 and 4)

-- Creating Constraint on Grad_Year --
ALTER TABLE Student
ADD CONSTRAINT GY
CHECK ((Grad_Year) BETWEEN YEAR(GETDATE()) - 5 AND YEAR(GETDATE()))


-- Creating Constraint on Intake Year--
Alter Table intake
add constraint YU
Unique(Year)



-- Creating Constraint on Department Name--
Alter Table Department
add constraint DNU
Unique(Name)

-- Creating Constraint on Track Name--
Alter Table Track
add constraint TNU
Unique(Name)

-- Creating Constraint on Branch Name--
Alter Table Branch
add constraint BNU
Unique(Name)

-- Creating Constraint on Course Name--
Alter Table Course
add constraint CNU
Unique(Name)

-- Creating Constraint on Ins Email --
Alter Table Instructor
add constraint EIN
Unique(Email)

-- Creating Constraint on Student Email --
Alter Table Student
add constraint ES
Unique(Email)

-- Creating Constraint on Exam Type--
Alter Table Exam
add constraint ET
check((Type) in ('exam', 'corrective'))

-- Creating Constraint on Question Type--
Alter Table Questions
add constraint QT
Check ((Type) in ('Multiple choice', 'True/False','Text'))

alter table Questions drop constraint QT

-----------------------------------------------------------------

-----------------------------Rules-------------------------------
Create Rule GEN_Rule as @col in ('M','F')
-------------------------- Binding Rules-------------------------
sp_bindrule GEN_Rule , 'Instructor.Gender'
sp_bindrule GEN_Rule , 'Student.Gender'
-----




