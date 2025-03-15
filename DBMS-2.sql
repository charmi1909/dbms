CREATE DATABASE CSE_4B_448

---------------LAB-1 Part – A----------------
---1 Retrieve a unique genre of songs
SELECT DISTINCT GENRE FROM SONGS

---2 Find top 2 albums released before 2010
SELECT TOP 2 *FROM albums WHERE release_year>2010

---3 Insert Data into the Songs Table. (1245, ‘Zaroor’, 2.55, ‘Feel good’, 1005)
INSERT INTO Songs VALUES (1245,'ZAROOR',2.5,'FEEL GOOD',1005)

---4 Change the Genre of the song ‘Zaroor’ to ‘Happy’
UPDATE Songs SET song_title='HAPPY' WHERE song_title='ZAROOR'

---5 Delete an Artist ‘Ed Sheeran’
DELETE Artists WHERE artist_name='ED SHEERAN'

---6 Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)]
ALTER TABLE SONGS ADD  RATING DECIMAL(3,2)

---7 Retrieve songs whose title starts with 'S'.
SELECT * FROM Songs WHERE SONG_TITLE LIKE 'S%'

---8 Retrieve all songs whose title contains 'Everybody'.
SELECT * FROM Songs WHERE SONG_TITLE LIKE '%EVERYBODY%'

---9 Display Artist Name in Uppercase.
SELECT UPPER(artist_name) from Artists

---10 Find the Square Root of the Duration of a Song ‘Good Luck’
SELECT SQRT(DURATION) FROM Songs WHERE song_title ='GOOD LUCK'

---11 Find Current Date.
SELECT GETDATE()

---12 Find the number of albums for each artist.
SELECT COUNT(ALBUM_TITLE),ARTIST_NAME 
FROM albums JOIN Artists
ON ALBUMS.Artist_id =ARTISTS.Artist_id 
GROUP BY artist_name

---13 Retrieve the Album_id which has more than 5 songs in it.
SELECT COUNT(SONG_TITLE),SONGS.ALBUM_ID 
FROM albums JOIN Songs
ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
WHERE ALBUMS.album_id > 5
GROUP BY SONGS.ALBUM_ID

---14 Retrieve all songs from the album 'Album1'. (using Subquery)
SELECT SONG_ID
FROM songs
WHERE album_id = (
    SELECT album_id
    FROM albums
    WHERE ALBUM_ID = 'Album1'
);
---15. Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery)

---16. Retrieve all the song titles with its album title.
SELECT Songs.song_title,albums.album_title,albums.album_id
FROM albums JOIN Songs
ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID

---17. Find all the songs which are released in 2020.
SELECT Songs.song_title, albums.album_id,albums.release_year
FROM albums JOIN Songs
ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
WHERE albums.release_year =2020

---18. Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105.
CREATE 
VIEW 
FAV_SONGS
AS 
SELECT * FROM SONGS
WHERE song_id >101 AND song_id<105



---19. Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view.
UPDATE FAV_SONGS
SET song_title='JANNAT'
WHERE song_id=101

---20. Find all artists who have released an album in 2020.
SELECT ARTISTS.ARTIST_NAME,ALBUMS.RELEASE_YEAR
FROM ARTISTS JOIN ALBUMS
ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID
WHERE ALBUMS.RELEASE_YEAR=2019

---21. Retrieve all songs by Shreya Ghoshal and order them by duration.



----------------LAB-2 PART-A--------------
-- Create Department Table
CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);
-- Create Designation Table
CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);
-- Create Person Table
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
)


--1. Department, Designation & Person Table’s INSERT, UPDATE & DELETE Procedures.
     -------DEPARTMENT INSERT PROCEDURES:

	 CREATE OR ALTER PROCEDURE PR_INSERT_DEPARTMENT
	 @DepartmentID INT,
	 @DEPARTMENTNAME VARCHAR(100)
	 AS
	 BEGIN 
	 INSERT INTO DEPARTMENT
	 VALUES 
	 (@DepartmentID,@DEPARTMENTNAME)
	 END

	 EXEC PR_INSERT_DEPARTMENT 1,'ADMIN'
	 EXEC PR_INSERT_DEPARTMENT 2,'IT'
	 EXEC PR_INSERT_DEPARTMENT 3,'HR'
	 EXEC PR_INSERT_DEPARTMENT 4,'ACCOUNT'

	 ------DEPARTMENT DELETE:
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_DELETE
@DEPARTMENTID INT
AS
BEGIN
	DELETE FROM Department
	WHERE DepartmentID=@DEPARTMENTID
	END

------DEPARTMENT UPDATE
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_UPDATE
@DEPARTMENTID INT,
@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	UPDATE Department
	SET DepartmentName=@DEPARTMENTNAME
	WHERE DepartmentID=@DEPARTMENTID
END


-------DESIGNATION INSERT PROCEDURES:

	 CREATE OR ALTER PROCEDURE PR_INSERT_DESIGNATION
	 @DESIGNATIONID INT,
	 @DESIGNATIONNAME VARCHAR(100)
	 AS
	 BEGIN 
	 INSERT INTO Designation
	 VALUES 
	 (@DESIGNATIONID,@DESIGNATIONNAME)
	 END

	 EXEC PR_INSERT_DESIGNATION 11,'JOBBER'
	 EXEC PR_INSERT_DESIGNATION 12,'WELDER'
	 EXEC PR_INSERT_DESIGNATION 13,'CLERK'
	 EXEC PR_INSERT_DESIGNATION 14,'MANAGER'
	 EXEC PR_INSERT_DESIGNATION 15,'CEO'

	 -----DESIGNATION DELETE:
CREATE OR ALTER PROCEDURE PR_DESIGNATION_DELETE
@DESIGNATIONID INT
AS
BEGIN
	DELETE FROM Designation
	WHERE DesignationID=@DESIGNATIONID
	END

	EXEC PR_DESIGNATION_DELETE 11

	SELECT * FROM Designation

------DESIGNATION UPDATE:

CREATE OR ALTER PROCEDURE PR_DESIGNATION_UPDATE
@DESIGNATIONID INT,
@DESIGNATIONNAME VARCHAR(100)
AS
BEGIN
	UPDATE Designation
	SET DESIGNATIONNAME=@DESIGNATIONNAME
	WHERE DESIGNATIONID=@DESIGNATIONID
END

-----PERSON INSERT:
CREATE OR ALTER PROCEDURE PR_PERSON_INSERT
@FirstName Varchar (100) ,
@LastName Varchar (100),
@Salary Decimal (8,2) ,
@JoiningDate Datetime ,
@DepartmentID Int,
@DesignationID Int 
AS
BEGIN
	INSERT INTO Person
	VALUES
	(@FirstName,@LastName,@Salary,@JoiningDate,@DepartmentID,@DesignationID)
END

EXEC PR_PERSON_INSERT 'RAHUL','ANSHU',56000,'1990-01-01',1,12
EXEC PR_PERSON_INSERT 'HARDIK','HINSHU',18000,'1990-09-25',2,11
EXEC PR_PERSON_INSERT 'BHAVIN','KAMANI',25000,'1991-05-14',NULL,11
EXEC PR_PERSON_INSERT 'BHOOMI','PATEL',39000,'2014-02-20',1,13
EXEC PR_PERSON_INSERT 'ROHIT','RAJGOR',17000,'1990-07-23',2,15
EXEC PR_PERSON_INSERT 'PRIYA','MEHTA',25000,'1990-10-18',2,NULL
EXEC PR_PERSON_INSERT 'NEHA','TRIVEDI',18000,'2014-02-20',3,15

SELECT * FROM PERSON



-------PERSON DELETE:
CREATE OR ALTER PROCEDURE PR_PERSON_DELETE
@PERSONID INT
AS
BEGIN
	DELETE FROM PERSON
	WHERE PersonID=@PERSONID
END


EXEC PR_PERSON_DELETE 101
SELECT * FROM PERSON

----PERSON UPDATE:
CREATE OR ALTER PROCEDURE PR_PERSON_UPDATE
@PERSONID INT,
@FIRSTNAME VARCHAR(100),
@LASTNAME VARCHAR(100),
@SALARY DECIMAL(8,2),
@JOININGDATE DATETIME,
@DEPARTMENTID INT,
@DESIGNATIONID INT
AS
BEGIN
	UPDATE PERSON
	SET 
	FIRSTNAME=@FIRSTNAME,
	LastName=@LASTNAME,
	Salary=@SALARY,
	JoiningDate=@JOININGDATE,
	DepartmentID=@DEPARTMENTID,
	DesignationID=@DESIGNATIONID
	WHERE
		PersonID=@PERSONID
END

--2. Department, Designation & Person Table’s SELECTBYPRIMARYKEY

---DEPARTMENT:
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_PRIMARYKEY
@DEPARTMENTID INT
AS
BEGIN
	SELECT * FROM Department
	WHERE DepartmentID=@DEPARTMENTID
END

----DESIGNATION:
CREATE OR ALTER PROCEDURE PR_DESIGNATION_PRIMARYKEY
@DESIGNATIONID INT
AS
BEGIN
	SELECT * FROM Designation
	WHERE DESIGNATIONID=@DESIGNATIONID
END

---PERSON:
CREATE OR ALTER PROCEDURE PR_PERSON_PRIMARYKEY
@PERSONID INT
AS
BEGIN
	SELECT * FROM PERSON
	WHERE PERSONID=@PERSONID
END

--3. Department, Designation & Person Table’s (If foreign key is available then do write join and takecolumns on select list)
CREATE OR ALTER PROCEDURE PR_LAB2_3
AS
BEGIN
	SELECT 
--4. Create a Procedure that shows details of the first 3 persons.
CREATE OR ALTER PROCEDURE PR_FIRST_THREE_PERSON
AS
BEGIN
	SELECT TOP 3 * FROM PERSON
	ORDER BY PersonID
END

EXEC PR_FIRST_THREE_PERSON


-----PART B---------

--5. Create a Procedure that takes the department name as input and returns a table with all workers working in that department.
CREATE OR ALTER PROCEDURE PR_DEPARTMENT
@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	SELECT PERSON.FirstName,PERSON.LastName,Department.DepartmentName
	FROM PERSON JOIN Department
	ON Person.DepartmentID=Department.DepartmentID
	WHERE DepartmentName=@DEPARTMENTNAME
END

EXEC PR_DEPARTMENT 'IT'
	
--6. Create Procedure that takes department name & designation name as input and returns a table with worker’s first name, salary, joining date & department name.
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_DESIGNATION
@DEPARTMENTNAME VARCHAR(100),
@DESIGNATIONNAME VARCHAR(100)
AS
BEGIN
	SELECT PERSON.FirstName,Person.Salary,Person.JoiningDate,Department.DepartmentName
	FROM PERSON JOIN Department
	ON
	Person.DepartmentID=Department.DepartmentID
	JOIN Designation
	ON
	Person.DesignationID=Designation.DesignationID
	WHERE DepartmentName=@DEPARTMENTNAME AND DesignationName=@DESIGNATIONNAME
END

EXEC PR_DEPARTMENT_DESIGNATION 'IT','JOBBER'

--7. Create a Procedure that takes the first name as an input parameter and display all the details of the worker with their department & designation name.
CREATE OR ALTER PROCEDURE PR_PROCEDURE_7
@FIRSTNAME VARCHAR(100)
AS
BEGIN
	SELECT PERSON.FirstName,PERSON.LastName,PERSON.Salary,Person.JoiningDate,Department.DepartmentName,Designation.DesignationName
	FROM PERSON JOIN Department
	ON
	Person.DepartmentID=Department.DepartmentID
	JOIN Designation
	ON
	Person.DesignationID=Designation.DesignationID
	WHERE FirstName=@FIRSTNAME
END	

EXEC PR_PROCEDURE_7 'NEHA'

--8. Create Procedure which displays department wise maximum, minimum & total salaries.
CREATE OR ALTER PROCEDURE PR_MAX_MIN_TOTAL_SALARY
AS
BEGIN
	SELECT Department.DepartmentName,MAX(PERSON.SALARY) AS MAX_SALARY,MIN(PERSON.SALARY) AS MIN_SALARY,SUM(PERSON.SALARY) AS TOTAL_SALARY
	FROM Department JOIN Person 
	ON
	Department.DepartmentID=Person.DepartmentID
	GROUP BY Department.DepartmentName
END

EXEC PR_MAX_MIN_TOTAL_SALARY
END

--9. Create Procedure which displays designation wise average & total salaries.
CREATE OR ALTER PROCEDURE PR_DESIGNATION_AVG_TOTAL
AS
BEGIN
	SELECT Designation.DesignationName,AVG(PERSON.SALARY) AS AVG_SALARY,SUM(PERSON.SALARY) AS TOTAL_SALARY
	FROM Designation JOIN Person 
	ON
	Designation.DesignationID=Person.DesignationID
	GROUP BY Designation.DesignationName
END

EXEC PR_DESIGNATION_AVG_TOTAL



--------PART-C--------

--10. Create Procedure that Accepts Department Name and Returns Person Count.
CREATE OR ALTER PROCEDURE PR_PROCEDURE_10
@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	SELECT COUNT(PERSON.PERSONID)AS PERSON_COUNT
	FROM Person JOIN Department
	ON Person.DepartmentID=Department.DepartmentID
	WHERE DepartmentName=@DEPARTMENTNAME
END

EXEC PR_PROCEDURE_10 'IT'

--11. Create a procedure that takes a salary value as input and returns all workers with a salary greater than input salary value along with their department and designation details.
CREATE OR ALTER PROCEDURE PR_PROCEDURE_11
@SALARY INT
AS
BEGIN
	SELECT Person.FirstName,Person.Salary,Department.DepartmentName,Designation.DesignationName
	FROM Person JOIN Department 
	ON
	Person.DepartmentID=Department.DepartmentID
	JOIN Designation
	ON 
	Person.DesignationID=Designation.DesignationID
	WHERE Salary>@SALARY
END

EXEC PR_PROCEDURE_11 25000

--12. Create a procedure to find the department(s) with the highest total salary among all departments.
CREATE OR ALTER PROCEDURE PR_PROCEDURE_12
AS
BEGIN
	SELECT MAX(PERSON.SALARY),Department.DepartmentName
	FROM Person JOIN Department 
	ON
	Person.DepartmentID=Department.DepartmentID
	GROUP BY Department.DepartmentNamE
END

EXEC PR_PROCEDURE_12




-----------	LAB-3 PART A------------

CREATE TABLE Departments (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE,
 ManagerID INT NOT NULL,
 Location VARCHAR(100) NOT NULL
);

CREATE TABLE Employee (
 EmployeeID INT PRIMARY KEY,
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 DoB DATETIME NOT NULL,
 Gender VARCHAR(50) NOT NULL,
 HireDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL,
 Salary DECIMAL(10, 2) NOT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Projects Table
CREATE TABLE Projects (
 ProjectID INT PRIMARY KEY,
 ProjectName VARCHAR(100) NOT NULL,
 StartDate DATETIME NOT NULL,
 EndDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location)
VALUES 
 (1, 'IT', 101, 'New York'),
 (2, 'HR', 102, 'San Francisco'),
 (3, 'Finance', 103, 'Los Angeles'),
 (4, 'Admin', 104, 'Chicago'),
 (5, 'Marketing', 105, 'Miami');

INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID, 
Salary)
VALUES 
 (101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00),
 (102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00),
 (103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00),
 (104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00),
 (105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00);

INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
VALUES 
 (201, 'Project Alpha', '2022-01-01', '2022-12-31', 1),
 (202, 'Project Beta', '2023-03-15', '2024-03-14', 2),
 (203, 'Project Gamma', '2021-06-01', '2022-05-31', 3),
 (204, 'Project Delta', '2020-10-10', '2021-10-09', 4),
 (205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5)


 --1. Create Stored Procedure for Employee table As User enters either First Name or Last Name and based on this you must give EmployeeID, DOB, Gender & Hiredate. 
 CREATE OR ALTER PROCEDURE PR_PROCEDURE_LAB3_1
 @FIRSTNAME VARCHAR(100)=NULL,
 @LASTNAME VARCHAR(100)=NULL
 AS
 BEGIN
	SELECT EMPLOYEEID,DOB,GENDER,HIREDATE
	FROM EMPLOYEE 
	WHERE FIRSTNAME=@FIRSTNAME OR LASTNAME=@LASTNAME
END

EXEC PR_PROCEDURE_LAB3_1 'ROBERT'

--2. Create a Procedure that will accept Department Name and based on that gives employees list who belongs to that department.
CREATE OR ALTER PROCEDURE PR_PROCEDURE_LAB3_2
@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	SELECT EMPLOYEE.FIRSTNAME,Department.DepartmentName
	FROM EMPLOYEE JOIN Department
	ON
	EMPLOYEE.DEPARTMENTID=Department.DepartmentID
	WHERE DepartmentName=@DEPARTMENTNAME
END

EXEC PR_PROCEDURE_LAB3_2 'IT'

--3. Create a Procedure that accepts Project Name & Department Name and based on that you must give all the project related details. 
CREATE OR ALTER PROCEDURE PR_PROCEDURE_LAB3_3
@PROJECTNAME VARCHAR(100),
@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	SELECT Projects.ProjectName,Projects.StartDate,Projects.EndDate,DepartmentS.DepartmentName
	FROM Projects JOIN Departments
	ON
	Projects.DepartmentID=Departments.DepartmentID
	WHERE ProjectName=@PROJECTNAME AND DepartmentName=@DEPARTMENTNAME
END

EXEC PR_PROCEDURE_LAB3_3 'PROJECT ALPHA','IT'

--4. Create a procedure that will accepts any integer and if salary is between provided integer, then those employee list comes in output. 
CREATE OR ALTER PROCEDURE PR_PROCEDURE_LAB3_4
@NUM1 INT,
@NUM2 INT
AS
BEGIN
	SELECT * FROM EMPLOYEE
	WHERE SALARY BETWEEN @NUM1 AND @NUM2
END

--5. Create a Procedure that will accepts a date and gives all the employees who all are hired on that date. 
CREATE OR ALTER PROCEDURE PR_PROCEDURE_LAB3_5
@HIREDATE DATETIME
AS
BEGIN
	SELECT * FROM EMPLOYEE
	WHERE HireDate=@HIREDATE
END

EXEC PR_PROCEDURE_LAB3_5 '2010-06-15'



---------PART-B--------

--6. Create a Procedure that accepts Gender’s first letter only and based on that employee details will be served.
CREATE OR ALTER PROCEDURE PR_LAB3_6
@GENDER VARCHAR(1)
AS
BEGIN
	SELECT * FROM Employee
	WHERE
	SUBSTRING(Gender, 1, 1) = @Gender
END

EXEC PR_LAB3_6 F

--7. Create a Procedure that accepts First Name or Department Name as input and based on that employee data will come. 
CREATE OR ALTER PROCEDURE PR_LAB3_7
@FIRSTNAME VARCHAR(100)=NULL,
@DEPARTMENTNAME VARCHAR(100)=NULL
AS
BEGIN
	SELECT Employee.EmployeeID,Employee.FirstName,Employee.LastName,Employee.GENDER,DepartmentS.DepartmentID
	FROM Employee JOIN DepartmentS
	ON
	Employee.DepartmentID=DepartmentS.DepartmentID
	WHERE FirstName=@FIRSTNAME OR DEPARTMENTNAME=@DEPARTMENTNAME

END

EXEC PR_LAB3_7 'JANE'
EXEC PR_LAB3_7 'HR'

--8. Create a procedure that will accepts location, if user enters a location any characters, then he/she will get all the departments with all data.
CREATE OR ALTER PROCEDURE PR_LAB3_8
@LOCATION VARCHAR(100)
AS
BEGIN
	SELECT DepartmentID,Location,ManagerID,DepartmentName FROM Departments
	WHERE location LIKE CONCAT ('%', @location ,'%');
END

EXEC PR_LAB3_8 'C'


---------PART-C--------

--9. Create a procedure that will accepts From Date & To Date and based on that he/she will retrieve Project related data.
CREATE OR ALTER PROCEDURE PR_LAB3_9
@STARTDATE DATETIME,
@ENDDATE DATETIME
AS
BEGIN
	SELECT * FROM Projects
	WHERE StartDate=@STARTDATE AND EndDate=@ENDDATE
END

EXEC PR_LAB3_9 '2022-01-01','2022-12-31'










----------LAB-4 PART(A)------------

--1. Write a function to print "hello world".
CREATE OR ALTER FUNCTION FN_LAB4_1()
RETURNS VARCHAR(100)
AS
BEGIN
	RETURN 'HELLO WORLD'
END



--2. Write a function which returns addition of two numbers.
CREATE OR ALTER FUNCTION FN_LAB4_2
(@NUM1 INT,@NUM2 INT)
RETURNS INT
AS
BEGIN
	RETURN @NUM1+@NUM2
END

SELECT DBO.FN_LAB4_2 (5,7)

--3. Write a function to check whether the given number is ODD or EVEN.
CREATE OR ALTER FUNCTION CheckOddEven(@Num INT)
RETURNS NVARCHAR(10)
AS
BEGIN
    IF @Num % 2 = 0
        RETURN 'EVEN'
    ELSE
        RETURN 'ODD'
	RETURN('NOT VALID')
END

SELECT DBO.CheckOddEven(7)

--4. Write a function which returns a table with details of a person whose first name starts with B.
CREATE OR ALTER FUNCTION FN_LAB4_4()
RETURNS TABLE
AS
 RETURN
 (SELECT * FROM Person WHERE FirstName LIKE 'B%')

 SELECT * FROM FN_LAB4_4()

--5. Write a function which returns a table with unique first names from the person table.
CREATE OR ALTER FUNCTION FN_LAB4_5()
RETURNS TABLE
AS
 RETURN
 (SELECT DISTINCT FIRSTNAME FROM Person )

 SELECT * FROM FN_LAB4_5()

--6. Write a function to print number from 1 to N. (Using while loop)
CREATE OR ALTER FUNCTION FN_LAB4_6(@NUM INT)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @ANS AS VARCHAR(MAX)
	SET @ANS=''
	DECLARE @I AS INT
	SET @I=1
	WHILE @I<=@NUM
	BEGIN
		SET @ANS=@ANS+CAST(@I AS VARCHAR)+''
		SET @I=@I+1
	END
	RETURN @ANS
END

SELECT DBO.FN_LAB4_6(10)

--7. Write a function to find the factorial of a given integer.
CREATE OR ALTER  FUNCTION FindFactorial(@Num INT)
RETURNS BIGINT
AS
BEGIN
    DECLARE @Factorial BIGINT = 1;
    DECLARE @Counter INT = 1;

    WHILE @Counter <= @Num
    BEGIN
        SET @Factorial = @Factorial * @Counter;
        SET @Counter = @Counter + 1;
    END

    RETURN @Factorial;
END

SELECT DBO.FindFactorial(10)


------------PART-(B)--------

--8. Write a function to compare two integers and return the comparison result. (Using Case statement)
CREATE OR ALTER FUNCTION FN_LAB4_8(@NUM1 INT,@NUM2 INT)
RETURNS VARCHAR(30)
AS
BEGIN
	RETURN (
		CASE
			WHEN @NUM1>@NUM2 THEN 'FIRST IS GREATER'
			WHEN @NUM1<@NUM2 THEN 'SECOND IS GREATER'
			ELSE 'BOTH ARE EQUAL'
		END
			)
END

SELECT DBO.FN_LAB4_8(5,5)
SELECT DBO.FN_LAB4_8(5,10)
SELECT DBO.FN_LAB4_8(5,3)

--9. Write a function to print the sum of even numbers between 1 to 20.
CREATE OR ALTER FUNCTION FN_LAB4_9()
RETURNS INT
AS
BEGIN
	DECLARE @ANS INT=0
	DECLARE @I INT=0

	WHILE @I<=20
	BEGIN
		SET @ANS=@ANS+@I
		SET @I=@I+2
	END
	RETURN @ANS
END

SELECT DBO.FN_LAB4_9()

--10. Write a function that checks if a given string is a palindrome
CREATE OR ALTER FUNCTION FN_LAB4_10(@WORD VARCHAR(300))
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @Reversed NVARCHAR(300);
    DECLARE @Length INT = LEN(@WORD);
    DECLARE @Counter INT = 1;
    SET @Reversed = '';

    WHILE @Counter <= @Length
    BEGIN
        SET @Reversed = @Reversed + SUBSTRING(@WORD, @Length - @Counter + 1, 1);
        SET @Counter = @Counter + 1;
    END

    IF @Reversed = @WORD
        RETURN 'YES'
    ELSE
        RETURN 'NO'
	RETURN('IN VALID')
END

SELECT DBO.FN_LAB4_10('HELLO')
SELECT DBO.FN_LAB4_10('HYH')



-------PART-(C)---------

--11. Write a function to check whether a given number is prime or not.
--12. Write a function which accepts two parameters start date & end date, and returns a difference in days.
CREATE OR ALTER FUNCTION FN_LAB4_12(@StartDate DATE, @EndDate DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(DAY, @StartDate, @EndDate);
END;

SELECT DBO.FN_LAB4_12('2024-01-01','2022-01-01')


------------LAB-6 PART A-----------

--  Create the Products table 
CREATE TABLE Products ( 
Product_id INT PRIMARY KEY, 
Product_Name VARCHAR(250) NOT NULL, 
Price DECIMAL(10, 2) NOT NULL )

--  Insert data into the Products table 
INSERT INTO Products (Product_id, Product_Name, Price) VALUES 
(1, 'Smartphone', 35000), 
(2, 'Laptop', 65000), 
(3, 'Headphones', 5500), 
(4, 'Television', 85000), 
(5, 'Gaming Console', 32000);

--1. Create a cursor Product_Cursor to fetch all the rows from a products table. 
DECLARE @Product_Cursor CURSOR
SET @Product_Cursor = CURSOR FOR
SELECT Product_id, Product_Name, Price
FROM Products
OPEN @Product_Cursor
FETCH NEXT FROM @Product_Cursor
WHILE @@FETCH_STATUS = 0
BEGIN
    FETCH NEXT FROM @Product_Cursor
END
CLOSE @Product_Cursor
DEALLOCATE @Product_Cursor

--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName. (Example: 1_Smartphone)
DECLARE @Product_Cursor_Fetch CURSOR
SET @Product_Cursor_Fetch = CURSOR FOR
SELECT CONVERT(VARCHAR, Product_id) + '_' + Product_Name AS ProductID_ProductName
FROM Products
OPEN @Product_Cursor_Fetch
FETCH NEXT FROM @Product_Cursor_Fetch
WHILE @@FETCH_STATUS = 0
BEGIN
    FETCH NEXT FROM @Product_Cursor_Fetch
END
CLOSE @Product_Cursor_Fetch
DEALLOCATE @Product_Cursor_Fetch

--3. Create a Cursor to Find and Display Products Above Price 30,000. 
DECLARE @PRODUCT_CUROSR_30000 CURSOR
SET @PRODUCT_CUROSR_30000=CURSOR FOR
SELECT * FROM Products WHERE PRICE>30000
OPEN @PRODUCT_CUROSR_30000
FETCH NEXT FROM @PRODUCT_CUROSR_30000
WHILE @@FETCH_STATUS=0
BEGIN
	FETCH NEXT FROM @PRODUCT_CUROSR_30000
END

CLOSE @PRODUCT_CUROSR_30000
DEALLOCATE @PRODUCT_CUROSR_30000

--4. Create a cursor Product_CursorDelete that deletes all the data from the Products table.
DECLARE @Product_CursorDelete CURSOR
SET @Product_CursorDelete = CURSOR FOR
SELECT Product_id
FROM Products
OPEN @Product_CursorDelete
FETCH NEXT FROM @Product_CursorDelete
WHILE @@FETCH_STATUS = 0
BEGIN
    DELETE FROM Products
    WHERE CURRENT OF @Product_CursorDelete
    FETCH NEXT FROM @Product_CursorDelete
END
CLOSE @Product_CursorDelete
DEALLOCATE @Product_CursorDelete





-------------LAB-5-------------
-----------PART-A------------

CREATE TABLE PersonInfo (
 PersonID INT PRIMARY KEY,
 PersonName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8,2) NOT NULL,
 JoiningDate DATETIME NULL,
 City VARCHAR(100) NOT NULL,
 Age INT NULL,
 BirthDate DATETIME NOT NULL
);

-- Creating PersonLog Table
CREATE TABLE PersonLog (
 PLogID INT PRIMARY KEY IDENTITY(1,1),
 PersonID INT NOT NULL,
 PersonName VARCHAR(250) NOT NULL,
 Operation VARCHAR(50) NOT NULL,
 UpdateDate DATETIME NOT NULL,
);
drop table PersonLog

--1. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the
--PersonInfo table to display a message “Record is Affected.” 

CREATE TRIGGER TR_PERSONINFO_RECORD
ON PERSONINFO
AFTER INSERT, UPDATE, DELETE
AS BEGIN
    PRINT ' RECORD IS AFFECTED '
END;

insert into PersonInfo values(2,'abc',1300,'2006-7-28','raj',18,'1998-9-9')
insert into PersonLog values (1,'xyz','update',GETDATE())

delete from PersonLog 
where PersonID =2

select * from PersonInfo
select * from PersonLog

drop trigger TR_PERSONINFO_RECORD



---Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that,log all operations performed on the person table into PersonLog.
-----INSERT------
CREATE TRIGGER TR_PERSONINFO_INSERT
ON PERSONINFO
AFTER INSERT
AS BEGIN  
     DECLARE @PERSONID INT;
	 DECLARE @PERSONNAME VARCHAR(50);
	 SELECT @PERSONID = PERSONID FROM INSERTED
	 SELECT @PERSONNAME = PERSONNAME FROM INSERTED

	 INSERT INTO PERSONLOG
	 VALUES ( @PERSONID, @PERSONNAME, 'INSERT', GETDATE())
END

-----------UPDATE---------

CREATE TRIGGER TR_PERSONINFO_UPDATE
ON PERSONINFO
AFTER UPDATE
AS BEGIN  
     DECLARE @PERSONID INT;
	 DECLARE @PERSONNAME VARCHAR(50);
	 SELECT @PERSONID = PERSONID FROM INSERTED
	 SELECT @PERSONNAME = PERSONNAME FROM INSERTED

	 INSERT INTO PERSONLOG
	 VALUES ( @PERSONID, @PERSONNAME, 'UPDATE', GETDATE())
END

-----------DELETE-----------

CREATE TRIGGER TR_PERSONINFO_DELETE
ON PERSONINFO
AFTER DELETE
AS BEGIN  
     DECLARE @PERSONID INT;
	 DECLARE @PERSONNAME VARCHAR(50);
	 SELECT @PERSONID = PERSONID FROM DELETED
	 SELECT @PERSONNAME = PERSONNAME FROM DELETED

	 INSERT INTO PERSONLOG
	 VALUES ( @PERSONID, @PERSONNAME, 'DELETE', GETDATE())
END

drop trigger TR_PERSONINFO_INSERT
drop trigger TR_PERSONINFO_UPDATE
drop trigger TR_PERSONINFO_DELETE

--4. Create a trigger that fires on INSERT operation on the PersonInfo table to convert 
--person name into uppercase whenever the record is inserted.

CREATE TRIGGER TR_PERSONINFO_INSERT4
ON PERSONINFO
AFTER UPDATE 
AS BEGIN 
     DECLARE @PERSONID INT;
	 DECLARE @PERSONNAME VARCHAR(50);
	 SELECT @PERSONID = PERSONID FROM INSERTED
	 SELECT @PERSONNAME = PERSONNAME FROM INSERTED

	 UPDATE PERSONINFO
	 SET PERSONNAME = UPPER(@PERSONNAME)
	 WHERE PERSONID = @PERSONID
END

drop trigger TR_PERSONINFO_INSERT4;


--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on
--the PersonInfo table. For that, log all operations performed on the person table into PersonLog.

CREATE TRIGGER TR_PERSONINFO_INSERT3
ON PERSONINFO
INSTEAD OF INSERT
AS BEGIN  
     DECLARE @PERSONID INT;
	 DECLARE @PERSONNAME VARCHAR(50);

	 SELECT @PERSONID = PERSONID FROM INSERTED
	 SELECT @PERSONNAME = PERSONNAME FROM INSERTED

	 INSERT INTO PERSONLOG (PERSONID, PERSONNAME, OPERATION, UPDATEDATE)
	 VALUES ( @PERSONID, @PERSONNAME, 'INSERT', GETDATE())
END
---update
CREATE TRIGGER TR_PERSONINFO_UPDATE3
ON PERSONINFO
INSTEAD OF UPDATE
AS BEGIN  
     DECLARE @PERSONID INT;
	 DECLARE @PERSONNAME VARCHAR(50);

	 SELECT @PERSONID = PERSONID FROM INSERTED
	 SELECT @PERSONNAME = PERSONNAME FROM INSERTED

	 INSERT INTO PERSONLOG (PERSONID, PERSONNAME, OPERATION, UPDATEDATE)
	 VALUES ( @PERSONID, @PERSONNAME, 'INSERT', GETDATE())
END


UPDATE  PERSONINFO
SET CITY='MORBI' 
WHERE Personid='2' 

SELECT * FROM PersonLog
SELECT * FROM PersonInfo


drop trigger TR_PERSONINFO_UPDATE
--DELETE
CREATE TRIGGER TR_PERSONINFO_DELETE5
ON PERSONINFO
INSTEAD OF DELETE
AS BEGIN  
     DECLARE @PERSONID INT;
	 DECLARE @PERSONNAME VARCHAR(50);

	 SELECT @PERSONID = PERSONID FROM INSERTED
	 SELECT @PERSONNAME = PERSONNAME FROM INSERTED

	 INSERT INTO PERSONLOG (PERSONID, PERSONNAME, OPERATION, UPDATEDATE)
	 VALUES ( @PERSONID, @PERSONNAME, 'delete', GETDATE())
END



DROP TRIGGER TR_PERSONINFO_INSERT5



-----5
 create trigger tr_duplicate_p_name
on PersonInfo 
instead of insert
as 
	begin 
	DECLARE @PersonID INT
	DECLARE @PersonName VARCHAR(50)	
	SELECT @PersonID = PersonID FROM inserted
	SELECT @PersonName = PersonName FROM inserted
	if exists (select 1 from PersonInfo where PersonName = @PersonName)
	begin
		print 'Duplicate Entry'
	end
	else
	begin
		insert into PersonInfo
		select * from inserted
	end
end

--------PART-B--------

--7. Create a trigger that fires on INSERT operation on person table, which calculates the age and update that age in Person table. 
CREATE TRIGGER trg_PersonInfo_Age
ON PersonInfo
AFTER INSERT
AS
BEGIN
    UPDATE p
    SET Age = DATEDIFF(YEAR, BirthDate, GETDATE())
    FROM PersonInfo p
    INNER JOIN inserted i ON p.PersonID = i.PersonID;
END;


--8. Create a Trigger to Limit Salary Decrease by a 10%. 
CREATE TRIGGER trg_PersonInfo_Salary
ON PersonInfo
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Salary)
    BEGIN
        IF EXISTS (
            SELECT *
            FROM deleted d
            INNER JOIN inserted i ON d.PersonID = i.PersonID
            WHERE d.Salary * 0.9 > i.Salary
        )
        BEGIN
            RAISERROR ('Salary decrease exceeds 10%.', 16, 1);
            ROLLBACK TRANSACTION;
        END
    END
END;



--------PART-C---------

--9. Create Trigger to Automatically Update JoiningDate to Current Date on INSERT if JoiningDate is NULL during an INSERT. 
CREATE TRIGGER trg_PersonInfo_JoiningDate
ON PersonInfo
AFTER INSERT
AS
BEGIN
    UPDATE p
    SET JoiningDate = GETDATE()
    FROM PersonInfo p
    INNER JOIN inserted i ON p.PersonID = i.PersonID
    WHERE i.JoiningDate IS NULL;
END;

--10. Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table it prints ‘Record deleted successfully from PersonLog’. 
CREATE TRIGGER trg_PersonLog_Delete
ON PersonLog
AFTER DELETE
AS
BEGIN
    PRINT 'Record deleted successfully from PersonLog.';
END;


----------
