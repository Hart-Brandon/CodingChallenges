--SELECT duplicate emails--
USE Projects /*Update schema name as needed*/

SELECT d.[name] AS Department, e.[name] AS Employee, e.Salary AS Salary
FROM Employee e JOIN Department d
ON e.departmentId = d.departmentId AND e.salary = (SELECT MAX(salary) 
												   FROM Employee 
												   WHERE departmentId = d.departmentId)
GROUP BY d.[name], e.[name], e.salary
ORDER BY salary DESC