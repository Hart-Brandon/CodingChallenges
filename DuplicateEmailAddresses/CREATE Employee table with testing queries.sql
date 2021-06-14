--CREATE table--
USE Projects

DROP TABLE IF EXISTS Employee 

CREATE TABLE Employee
(
	employeeId INT NOT NULL PRIMARY KEY,
	email VARCHAR(MAX)
)
GO

--INSERT Employee info--
INSERT INTO Employee (employeeId, email)
VALUES 
(1, 'bob.smith@somwhere.com'),
(2, 'eric.jones@somewhere.com'),
(3, 'Jill.brown@somewhere.com'),
(4, 'bob.smith@somwhere.com')
GO

--SELECT all Employee info-
SELECT employeeId, email
  FROM Employee
GO