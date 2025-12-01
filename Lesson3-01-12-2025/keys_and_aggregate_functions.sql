CREATE SEQUENCE Dept_Sequence
	START WITH 1
	INCREMENT BY 1
	CACHE 10;

	CREATE TABLE Department_Sequence (
		DepartmentID INT PRIMARY KEY IDENTITY(1,1),  -- IDENTITY(1,1) increment each time primary key by 1
		DepartmentName NVARCHAR(100),
		Location NVARCHAR(100)
	);

INSERT INTO Department_Sequence (DepartmentName)
VALUES (NEXT VALUE FOR Dept_Sequence, 'Marketing');

--DROP TABLE Department_Sequence
--DROP SEQUENCE Dept_Sequence

SELECT * FROM Department_Sequence

INSERT INTO Department (DepartmentName, Location) VALUES
('Human Resources', 'New York'),
('Software Engineering', 'Seattle'),
('Marketing', 'Boston'),
('Finance', 'New York'),
('Operations', 'Chicago');

SELECT * FROM Department

CREATE TABLE Employees (
	EmployeeID INT PRIMARY KEY IDENTITY(1,1),
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth DATE,
	Salary DECIMAL(10, 2),
	DepartmentID INT,

	CONSTRAINT FK_Employee_Department
		FOREIGN KEY (DepartmentID)
		REFERENCES Department (DepartmentID)
)

SELECT * FROM Employees

INSERT INTO Employees (FirstName, LastName, DateOfBirth, Salary, DepartmentID) VALUES
('Jonh', 'Doe' , '1985-05-15', 85000.00, 2),
('Jane', 'Smith', '1990-08-22', 72000.00, 3),
('Robert', 'Brown', '1978-01-10', 95000.00, 1),
('Emily', 'Davis', '1995-11-01', 78000.00, 2),
('Michael', 'Wilson', '1982-03-25', 120000.00, 4),
('Jessica', 'Lee', '1988-07-19', 65000.00, 5),
('David', 'Chen', '1992-04-30', 90000.00, 2),
('Sarah', 'King', '1987-12-05', 70000.00, 3),
('Chris', 'Evans', '1975-02-14', 105000.00, 1),
('Maria', 'Lopez', '1994-06-03', 110000.00, 4),
('John' , 'Karelas' , '1985-05-15', 85000.00, 2);

SELECT * FROM Department

CREATE TABLE EmployeeChildren (
	EmployeeID INT NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth DATE,

	CONSTRAINT FK_Employee_EmployeeChildren
		FOREIGN KEY(EmployeeID)
		REFERENCES Employees(EmployeeID),

	CONSTRAINT PK_EmployeeChildren
		PRIMARY KEY(EmployeeID, FirstName, LastName, DateOfBirth)
)

INSERT INTO EmployeeChildren (EmployeeID, FirstName, LastName, DateOfBirth) VALUES
-- John Doe (ID 1) - 3 children
(1, 'Alice', 'Doe', '2015-02-01'),
(1, 'Ben', 'Doe', '2018-09-10'),
(1, 'Chloe', 'Doe', '2020-03-17'),
-- Jane Smith (ID 2) - 2 children
(2, 'Daniel', 'Smith', '2012-11-20'),
(2, 'Ella', 'Smith', '2019-06-05'),
-- Robert Brown (ID 3) - 1 child
(3, 'Frank', 'Brown', '2022-01-28'),
-- Emily Davis (ID 4) - 3 children
(4, 'Grace', 'Davis', '2014-04-12'),
(4, 'Henry', 'Davis', '2016-10-30'),
(4, 'Ivy', 'Davis', '2023-08-08'),
-- Michael Wilson (ID 5) - 2 children
(5, 'Jack', 'Wilson', '2011-07-07'),
(5, 'Kim', 'Wilson', '2017-02-23'),
-- Jessica Lee (ID 6) - 2 children
(6, 'Leo', 'Lee', '2013-05-18'),
(6, 'Mia', 'Lee', '2021-04-04'),
-- David Chen (ID 7) - 1 child
(7, 'Noah', 'Chen', '2010-09-29'),
-- Sarah King (ID 8) - 4 children
(8, 'Olivia', 'King', '2012-03-15'),
(8, 'Peter', 'King', '2015-08-25'),
(8, 'Quinn', 'King', '2018-01-05'),
(8, 'Riley', 'King', '2024-02-10'),
-- Chris Evans (ID 9) - 1 child
(9, 'Sam', 'Evans', '2019-12-01'),
-- Maria Lopez (ID 10) - 1 child
(10, 'Taylor', 'Lopez', '2020-07-20');

SELECT * FROM EmployeeChildren

CREATE TABLE EmployeeSales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    SaleDate DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Region VARCHAR(50) NOT NULL,
    -- Foreign Key to the Employees table
    CONSTRAINT FK_EmployeeSales_Employee
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees (EmployeeID)
);

INSERT INTO EmployeeSales (EmployeeID, SaleDate, Amount, Region) VALUES
-- Employee 1 (John Doe)
(1, '2025-10-01', 5000.00, 'North'),
(1, '2025-10-15', 8500.00, 'South'),
(1, '2025-11-05', 4200.00, 'North'),
-- Employee 2 (Jane Smith)
(2, '2025-10-02', 2100.00, 'West'),
(2, '2025-11-10', 3500.00, 'West'),
-- Employee 3 (Robert Brown)
(3, '2025-10-05', 12000.00, 'East'),
-- Employee 4 (Emily Davis)
(4, '2025-10-10', 9500.00, 'North'),
(4, '2025-11-02', 11000.00, 'North'),
(4, '2025-11-20', 1000.00, 'South'), -- Low sale
-- Employee 5 (Michael Wilson)
(5, '2025-10-12', 15000.00, 'East'),
-- Employee 6 (Jessica Lee)
(6, '2025-10-18', 6000.00, 'West'),
(6, '2025-11-15', 7500.00, 'West'),
-- Employee 7 (David Chen)
(7, '2025-10-25', 10000.00, 'North'),
(7, '2025-11-08', 9800.00, 'North'),
-- Employee 8 (Sarah King)
(8, '2025-11-01', 5500.00, 'South'),
(8, '2025-11-25', 6200.00, 'South'),
-- Employee 9 (Chris Evans)
(9, '2025-10-30', 18000.00, 'East'),
(9, '2025-11-18', 14000.00, 'East'),
-- Employee 10 (Maria Lopez)
(10, '2025-10-20', 3000.00, 'West'),
(10, '2025-11-04', 1200.00, 'West');

SELECT * FROM EmployeeSales;

SELECT c.FirstName, c.LastName, e.FirstName as ParentFirstName FROM Employees e 
LEFT JOIN EmployeeChildren c
ON e.EmployeeID = c.EmployeeID




-- Aggregate functions,  eg. SUM, COUNT, AVERAGE, MIN/MAX

SELECT SUM(Salary) as TotalEmployeeSalary 
FROM Employees;

SELECT SUM(Amount) 
FROM EmployeeSales
WHERE EmployeeID = 1;

SELECT SUM(Distinct Amount)
FROM EmployeeSales
WHERE EmployeeID = 1;

SELECT COUNT(*)
FROM EmployeeSales
WHERE EmployeeID = 1;

SELECT COUNT(*)
FROM Employees;

SELECT COUNT(Distinct DepartmentID)
FROM Employees;

SELECT
	E.FirstName + ' ' + E.LastName AS EmployeeName
FROM Employees E
