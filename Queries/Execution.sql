
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




--SP To Add Branch (@ID, @Name)
execute Add_Branch 12,'Sohag'


--SP To Add Department (@ID, @Name)
execute Add_Department 7,'Cloud'


--SP To Add Track (@ID, @Name, @Dept_ID)
execute Add_Track 12,'Sales Force',6


--SP To Add Intake (@ID, @Year, @Start_Date, @End_Date)
execute Add_Intake 3,2025,'2025-09-01','2026-06-30'


--SP To Register Student (@NID, @Full_Name, @Gender, @Birth_Date, @Email, @Phone, @City, 
--                               @College, @GPA, @Grad_Year, @Track_ID, @Intake_ID, @Branch_ID)
execute Register_Student @NID = 299, @Full_Name = 'Mohammad Anwar elhassas', @Gender = 'M', 
						 @Birth_Date = '1999-08-20', @Email = 'anwar@iti.eg', @Phone = '010608036513',
						 @City = 'El Santa', @College = 'FCAI', @GPA = 4, @Grad_Year = 2022, 
						 @Track_ID = 1, @Intake_ID = 2, @Branch_ID = 5


--SP To Register Instructor (@NID, @Full_Name, @Gender, @Birth_Date, @Phone, @Email, @City, @Salary, @Dept_ID)
execute Register_Instructor @NID = 21, @Full_Name = 'Ahmed Ali', @Gender = 'M', @Birth_Date = '2000-10-1',
							@Email = 'ahmed@iti.eg', @Phone = '01096296172', @City = 'Tanta', @Salary = 15000, 
							@Dept_ID = 1


--SP To Register Course (@ID, @Name, @Description, @Min_Degree, @Max_Degree)
execute Register_Course @ID = 26, @Name = 'Statistics', @Description = 'Intro to Statistics', 
						@Min_Degree = 40, @Max_Degree = 80

-----------------------------------------------------------------------------------------------------

--SP To Edit Branch (@ID, @Name)
execute Edit_Branch 1,'Tanta'


--SP To Edit Department (@ID, @Name)
execute Edit_Department 5, 'Computer Network'


--SP To Edit Track (@ID, @Name,@Dept_ID)
execute Edit_Track 7,'Data Engineering',2


--SP To Edit Intake (@ID, @Name)
execute Edit_Intake 2,2055,'2054-09-01','2055-06-30'


--SP To Edit Student (@NID, @Full_Name, @Gender, @Birth_Date, @Email, @Phone, @City, 
--                               @College, @GPA, @Grad_Year, @Track_ID, @Intake_ID, @Branch_ID)
execute Edit_Student @NID = 299, @Full_Name = 'Mohammad Anwar elgamed', @Gender = 'M'

						


--SP To Edit Instructor (@NID, @Full_Name, @Gender, @Birth_Date, @Phone, @Email, @City, @Salary, @Dept_ID)
execute Edit_Instructor @NID = 21, @Full_Name = 'osman demble', @Gender = 'M', @Birth_Date = '2000-10-1'


							


--SP To Edit Course (@ID, @Name, @Description, @Min_Degree, @Max_Degree)
execute Edit_Course @ID = 26, @Name = 'hhhhhhhhhhhhhh', @Description = 'Intro to Statistics'
						

-----------------------------------------------------------------------------------------------------

--SP To Remove Branch (@ID)
execute Remove_Branch 12


--SP To Remove Department (@ID)
execute Remove_Department 7


--SP To Remove Track (@ID)
execute Remove_Track 12



--SP To Remove Intake (@ID)
execute Remove_Intake 3


--SP To Remove Student (@NID)
execute Remove_Student 299


--SP To Remove Instructor (@NID)
execute Remove_Instructor 21


--SP To Remove Course (@ID)
execute Remove_Course 26

-----------------------------------------------------------------------------------------------------

--SP To Assign An Instructor To Course (@InstructorID, @CourseID)
execute Assign_Course_To_Instructor @InstructorID = 1, @CourseID = 15

-----------------------------------------------------------------------------------------------------

--SP To Create An Exam (@ID, @No_Question, @Type, @Date, @Start_Time, @End_Time,
--                       @Total_Degree, @InstructorID, @CourseID, @IntakeID, @BranchID, @TrackID)

		           		--Successfull Execution--
execute Create_Exam   @ID = 111,@No_Question = 20,@Type = 'Exam',@Date = '2025-09-02',
						@Start_Time = '14:22',@End_Time = '16:00',@Total_Degree = 50, 
						@InstructorID = 2, @CourseID = 4,@IntakeID = 1, @BranchID = 1, 
						@TrackID = 4;


			--Error because this course is not assigned to this instructor--
execute Create_Exam   @ID = 50,@No_Question = 20,@Type = 'Exam',@Date = '2025-09-10',
						@Start_Time = '10:00',@End_Time = '12:00',@Total_Degree = 50, 
						@InstructorID = 2, @CourseID = 5,@IntakeID = 1, @BranchID = 1, 
						@TrackID = 3;

-----------------------------------------------------------------------------------------------------

--SP To Add Questions To Exam Randomly (@ExamID, @NumberOfQuestions)
	-- (the number of questions and total degree will be updated when adding new questions)

select * from Exam where Exam.ID=100
execute Add_Questions_Randomly  @ExamID = 111, @NumberOfQuestions = 1

-------------------------

--SP To Add Question To Exam Manually (@ExamID, @QuestionID)

					--(Successfull Execution)--	
execute Add_Questions_Manulally 111,95


			--(Error because Question does not belong to the same course as the exam)--	
execute Add_Questions_Manulally 40,140

-----------------------------------------------------------------------------------------------------

--SP To View Exam (@E_ID ,@Student_ID)
execute View_Exam 111,30010007


--SP To Add Or Edit Student_Answer (@Exam_ID, @Student_ID, @Question_ID, @Answer)
execute Submit_Answer 111,30010007,115,'C'


--SP To Compare Submitted Answers With Correct Answers (@Student_ID, @Exam_ID)
execute Compare_Answer 30010007, 111


--SP To Get Final Result For Student In Exam (@Student_ID, @Exam_ID)
execute Calculate_Result 30010007, 111


--SP To Get Final Result For Instructor In His Course (@Instructor_ID, @Course_ID)
execute Course_Result 1, 11

select * from Questions

