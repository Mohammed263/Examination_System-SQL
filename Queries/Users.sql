
--Create Logins

CREATE LOGIN [Admin] WITH PASSWORD = '111';
CREATE LOGIN T_Manager WITH PASSWORD = '222';
CREATE LOGIN Instructor WITH PASSWORD = '333';
CREATE LOGIN Student WITH PASSWORD = '444';


-- Create Users

CREATE USER [Admin] FOR LOGIN [Admin];
CREATE USER T_Manager FOR LOGIN T_Manager;
CREATE USER Instructor FOR LOGIN Instructor;
CREATE USER Student FOR LOGIN Student;

--------------------------------------------------------------------------------------------

----------------Permissions For Admin

GRANT CONTROL ON DATABASE::[Examination System] TO [Admin]

------------------------------------------------------

----------------Permissions For Training Manager


--Permissions On Stored Procedures

GRANT EXECUTE ON Add_Branch TO T_Manager
GRANT EXECUTE ON Add_Department TO T_Manager
GRANT EXECUTE ON Add_Track TO T_Manager
GRANT EXECUTE ON Add_Intake TO T_Manager
GRANT EXECUTE ON Register_Student TO T_Manager
GRANT EXECUTE ON Register_Instructor TO T_Manager
GRANT EXECUTE ON Register_Course TO T_Manager
GRANT EXECUTE ON Edit_Branch TO T_Manager
GRANT EXECUTE ON Edit_Department TO T_Manager
GRANT EXECUTE ON Edit_Track TO T_Manager
GRANT EXECUTE ON Edit_Intake TO T_Manager
GRANT EXECUTE ON Edit_Student TO T_Manager
GRANT EXECUTE ON Edit_Instructor TO T_Manager
GRANT EXECUTE ON Edit_Course TO T_Manager
GRANT EXECUTE ON Remove_Branch TO T_Manager
GRANT EXECUTE ON Remove_Department TO T_Manager
GRANT EXECUTE ON Remove_Track TO T_Manager
GRANT EXECUTE ON Remove_Intake TO T_Manager
GRANT EXECUTE ON Remove_Student TO T_Manager
GRANT EXECUTE ON Remove_Instructor TO T_Manager
GRANT EXECUTE ON Remove_Course TO T_Manager
GRANT EXECUTE ON Assign_Course_To_Instructor TO T_Manager



--Permissions On Views

GRANT SELECT ON Track_Info TO T_Manager
GRANT SELECT ON Student_Info TO T_Manager
GRANT SELECT ON Instructor_Info TO T_Manager
GRANT SELECT ON Student_Results TO T_Manager
GRANT SELECT ON Exam_Statistics TO T_Manager



--------------------------

----------------Permissions For Instructor

GRANT EXECUTE ON Create_Exam TO Instructor
GRANT EXECUTE ON Add_Questions_Randomly TO Instructor
GRANT EXECUTE ON Add_Questions_Manulally TO Instructor
GRANT EXECUTE ON Calculate_Result TO Instructor
GRANT EXECUTE ON Course_Result TO Instructor

--------------------------

----------------Permissions For Student

GRANT EXECUTE ON View_Exam TO Student
GRANT EXECUTE ON Submit_Answer TO Student
GRANT EXECUTE ON Calculate_Result TO Student


