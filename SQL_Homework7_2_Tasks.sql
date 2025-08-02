Create database Teachers

Use Teachers

--- Task 1 ---
Create Table Posts(
	Id int Primary key,
	Name nvarchar(20) not null
)

Create Table Teachers (
    Id int primary key,
    Name nvarchar(15) not null,
    Code char(10),
    IdPost int,
    Tel char(7),
    Salary int,
    Rise numeric(6,2),
    HireDate datetime,
    Foreign key (IdPost) references Posts(Id)
)

--- Task 2 ---
-- 2. Delete the "POSTS" table:  
Alter Table Teachers 
Drop Constraint FK__Teachers__IdPost__4BAC3F29
Drop Table Posts

--- Task 3 ---
-- 3. In the "TEACHERS" table, delete the "IdPost" column:
Alter Table Teachers 
Drop Column IdPost

--- Task 4 ---
-- 4. For the "HireDate" column, create a limit: the date of hiring must be at least 01/01/1990: 
Alter Table Teachers
Add Constraint CK_HireDate Check( Hiredate>= '1990-01-01')

--- Task 5 ---
-- 5. Create a unique constraint for the "Code" column:  
Alter Table Teachers
Add Constraint UQ_Teachers_Code Unique(Code)

--- Task 6 ---
-- 6. Change the data type In the Salary field from INTEGER to NUMERIC (6,2)
Alter Table Teachers 
Alter Column Salary Numeric(6,2)

--- Task 7 ---
-- 7. Add to the table "TEACHERS" the following restriction: the salary should not be less than 1000, 
-- but also should not Exceed 5000. 
Alter Table Teachers
Add Constraint CK_Salary_Range Check(Salary between 1000 and 5000)

--- Task 8 ---
-- 8. Rename Tel column to Phone:
Exec sp_rename 'Teachers.Tel', 'Phone', 'COLUMN'

--- Task 9 ---
-- 9. Change the data type in the Phone field from CHAR (7) to CHAR (11):  
Alter Table Teachers
Alter Column Phone char(11)

--- Task 10 ---
--10. Create again the "POSTS" table:
Create Table Posts(
	Id int Primary key,
	Name nvarchar(20) not null
)

--- Task 11 ---
-- 11. For the Name field of the "POSTS" table, you must set a limit on the position (professor, 
-- assistant professor, teacher or assistant):
Alter Table Posts
Add Constraint CK_Posts_Name Check(Name in ('Professor', 'Assistant Professor', 'Teacher', 'Assistant'))

--- Task 12 ---
-- 12. For the Name field of the "TEACHERS" table, specify a restriction in which to prohibit the 
-- presence of figures in the teacher's surname:
Alter Table Teachers
Add Constraint CK_Teachers_Name_NoDigits
Check(Name not like '%[0-9]%')

--- Task 13 ---
-- 13. Add the IdPost (int) column to the "TEACHERS" table:
Alter Table Teachers
Add IdPost int

--- Task 14 ---
-- 14. Associate the field IdPost table "TEACHERS" with the field Id of the table "POSTS".
Alter Table Teachers
Add Constraint FK_Teachers_IdPost
Foreign key(IdPost) references Posts(Id)

--- Task 15 ---
-- 15. Fill both tables with data: 
--- VERSION 1 ---
BEGIN TRY
    INSERT INTO Posts (Id, Name) VALUES (1, N'Professor');
    INSERT INTO Posts (Id, Name) VALUES (2, N'Docent');
    INSERT INTO Posts (Id, Name) VALUES (3, N'Teacher');
    INSERT INTO Posts (Id, Name) VALUES (4, N'Assistant');

    INSERT INTO Teachers (Id, Name, Code, IdPost, Phone, Salary, Rise, HireDate)  
    VALUES (1, N'Sidorov', ' 0123456789 ', 1, NULL, 1070, 470, '01 .09.1992');

    INSERT INTO Teachers (Id, Name, Code, IdPost, Phone, Salary, Rise, HireDate)  
    VALUES (2, N'Ramishevsky', ' 4567890123 ', 2, ' 4567890 ', 1110, 370, '09 .09.1998');

    INSERT INTO Teachers (Id, Name, Code, IdPost, Phone, Salary, Rise, HireDate)  
    VALUES (3, N'Horenko', ' 1234567890 ', 3, NULL, 2000, 230, '10 .10.2001');

    INSERT INTO Teachers (Id, Name, Code, IdPost, Phone, Salary, Rise, HireDate)  
    VALUES (4, N'Vibrovsky', ' 2345678901 ', 4, NULL, 4000, 170, '01 .09.2003');

    INSERT INTO Teachers (Id, Name, Code, IdPost, Phone, Salary, Rise, HireDate)  
    VALUES (5, N'Voropaev', NULL, 4, NULL, 1500, 150, '02 .09.2002');

    INSERT INTO Teachers (Id, Name, Code, IdPost, Phone, Salary, Rise, HireDate)  
    VALUES (6, N'Kuzintsev', ' 5678901234 ', 3, ' 4567890 ', 3000, 270, '01 .01.1991');

    PRINT 'Data inserted successfully!'

END TRY

BEGIN CATCH
    PRINT 'Error occured!'
    PRINT ERROR_MESSAGE()
END CATCH

DELETE FROM Teachers;
DELETE FROM Posts;

--- VERSION 2 ---
BEGIN TRY

    INSERT INTO Posts (Id, Name) VALUES (1, N'Professor');
    INSERT INTO Posts (Id, Name) VALUES (2, N'Assistant Professor');
    INSERT INTO Posts (Id, Name) VALUES (3, N'Teacher');
    INSERT INTO Posts (Id, Name) VALUES (4, N'Assistant');

    INSERT INTO Teachers (Id, Name, Code, IdPost, Phone, Salary, Rise, HireDate)  
    VALUES (1, N'Sidorov', '012345690', 1, '01234567890', 1070.00, 470.00, '1992-09-01');

    INSERT INTO Teachers (Id, Name, Code, IdPost, Phone, Salary, Rise, HireDate)  
    VALUES (2, N'Ramishevsky', '456789123', 2, '45678901234', 1110.00, 370.00, '1998-09-09');

    INSERT INTO Teachers (Id, Name, Code, IdPost, Phone, Salary, Rise, HireDate)  
    VALUES (3, N'Horenko', '123456780', 3, '12345678901', 2000.00, 230.00, '2001-10-10');

    INSERT INTO Teachers (Id, Name, Code, IdPost, Phone, Salary, Rise, HireDate)  
    VALUES (4, N'Vibrovsky', '234567801', 4, '23456789012', 4000.00, 170.00, '2003-09-01');

    INSERT INTO Teachers (Id, Name, Code, IdPost, Phone, Salary, Rise, HireDate)  
    VALUES (5, N'Voropaev', '345678902', 4, '34567890123', 1500.00, 150.00, '2002-09-02');

    INSERT INTO Teachers (Id, Name, Code, IdPost, Phone, Salary, Rise, HireDate)  
    VALUES (6, N'Kuzintsev', '567890134', 3, '45678901234', 3000.00, 270.00, '1991-01-01');

    PRINT 'Data inserted successfully!'

END TRY

BEGIN CATCH
    PRINT 'Error occured!'
    PRINT ERROR_MESSAGE()
END CATCH

--- Task 16 ---

-- 16.1. All job titles:
Create view V_AllPosts as 
Select Name as PostTitle from Posts

Select * from V_AllPosts

-- 16.2. All the names of teachers: 
Create view V_AllTeacherNames as 
Select Name as TeacherName from Teachers

Select* from V_AllTeacherNames

-- 16.3. The identifier, the name of the teacher, his position, the general s / n (sort by s \ n):
Create view V_TeacherWithTotalSalary as
Select 
    t.Id, 
    t.Name, 
    p.Name as PostTitle, 
    (t.Salary + t.Rise) as TotalSalary
from Teachers t
Join Posts p on t.IdPost = p.Id;

Select* from V_TeacherWithTotalSalary
Order by TotalSalary

-- 16.4. Identification number, surname, telephone number (only those who have a phone number):
Create view V_TeachersWithPhone as
Select Id, Name as Surname, Phone 
from Teachers
Where Phone is not null

Select * from V_TeachersWithPhone

-- 16.5. Surname, position, date of admission in the format [dd/mm/yy]: 
Create view V_TeacherDateFormat_DDMMYY as
Select 
    t.Name as Surname, 
    p.Name as Position,
    Convert(varchar(8), t.HireDate, 3) as HireDateFormatted
from Teachers t
Join Posts p on t.IdPost = p.Id

Select * from V_TeacherDateFormat_DDMMYY

-- 16.6. Surname, position, date of receipt in the format [dd month_text yyyy]:
Create view V_TeacherDateFormat_Text as
Select 
    t.Name as Surname,
    p.Name as Position,
    Format(t.HireDate, 'dd MMMM yyyy', 'en-us') as HireDateFormatted
from Teachers t
Join Posts p on t.IdPost = p.Id

Select * from V_TeacherDateFormat_Text