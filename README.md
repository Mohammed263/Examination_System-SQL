# Examination System Database

## 📌 Project Overview
The **Examination System Database** is a SQL Server project that manages the full **exam lifecycle**:  
- Creating exams  
- Assigning questions  
- Submitting student answers  
- Automatic grading  
- Calculating and reporting results  

This project showcases advanced SQL Server programming with stored procedures, triggers, constraints, and views to ensure data integrity and automation.  

---

## ⚙️ Exam Process Flow
1. **Question Bank**  
   - Instructors create and manage a pool of questions (MCQ, True/False, Text).  
   - Each question is linked to a course and has a degree (mark).  

2. **Exam Creation**  
   - Exams are created and linked to courses, tracks, branches, and intakes.  
   - Questions are assigned to exams (either manually or randomly).  

3. **Student Participation**  
   - Students are assigned exams through the system.  
   - Answers are recorded in `Exam_Student_Questions_Answers`.  

4. **Automatic Grading**  
   - Objective questions (MCQ, True/False) are graded automatically by comparing with the correct answer.  
   - Marks are stored per question.  

5. **Result Calculation**  
   - `Calculate_Result` procedure sums correct answers and returns the student’s final score per exam.  
   - `CourseResult` procedure gives instructors an overview of student performance in their course.  

---

## 📊 Example Stored Procedures
- `Register_Student` – Add new students.  
- `Register_Instructor` – Add new instructors.  
- `Register_Course` – Add new courses.  
- `Calculate_Result` – Calculate final score for a student in a specific exam.  
- `CourseResult` – Show student scores for a course taught by an instructor.  

---

## 🛠️ Technologies
- **Database:** Microsoft SQL Server 2022  
- **Language:** T-SQL (DDL, DML, Stored Procedures, Triggers, Views)  
- **Backup & Restore:** `.bak` file for database recovery  
- **Diagrams:** ERD & Mapping  

---

## 📂 Repository Structure
```
├── Queries/                # SQL scripts (DDL, DML, Stored Procedures, Views, Triggers)
├── ERD-Mapping/            # ERD diagrams and mapping documents
├── Database/               # Database backup file (.bak)
├── Documentation/          # Project report (PDF)
└── README.md               # Project description
```

---

## ▶️ How to Use
1. Restore the database from the provided `.bak` file in SQL Server.  
2. Run SQL scripts in `Queries/` to create and test procedures, views, and triggers.  
3. Use `Calculate_Result` and `CourseResult` to analyze exam outcomes.  
4. Refer to `Documentation/Examination System Documentation.pdf` for full project details.  

---

## 👤 Author
**Mohammad Anwar Ahmed**  
- 💼 BI and Data Analyst   

## 📅 Date
August 2025
August 2025  

