--SELECT duplicate emails--
USE Projects /*Update schema name as needed*/

SELECT email
FROM Employee
GROUP BY email
HAVING COUNT(*) > 1