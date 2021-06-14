USE Projects

--CREATE Deparment table--
DROP TABLE IF EXISTS Department

CREATE TABLE Department
(
	departmentId INT NOT NULL PRIMARY KEY,
	[name] VARCHAR(MAX)
)
GO

--INSERT Department info--
INSERT INTO Department (departmentId, [name])
VALUES
	(1, 'Sales'),
	(2, 'Marketing')
GO

--CREATE Employee table--
DROP TABLE IF EXISTS Employee 

CREATE TABLE Employee
(
	employeeId INT NOT NULL PRIMARY KEY,
	[name] VARCHAR(MAX),
	salary INT,
	departmentId INT FOREIGN KEY REFERENCES Department(departmentId)
)
GO

--INSERT Employee info--
INSERT INTO Employee (employeeId, [name], salary, departmentId)
VALUES 
(1, 'Eric', 85000, 1),
(2, 'Jill', 95000, 1),
(3, 'Bob', 76000, 2),
(4, 'Emily', 76000, 2),
(5, 'Sam', 75000, 2)
GO

--SELECT all Employee info-
SELECT employeeId, [name], salary, departmentId
  FROM Employee
GO

--SELECT all Department info--
SELECT departmentId, [name]
FROM Department