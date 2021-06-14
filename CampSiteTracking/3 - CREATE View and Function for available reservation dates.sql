
--Create View: Change schema name if neccessary
DROP VIEW IF EXISTS dbo.AvailableReservationDates
GO

CREATE VIEW AvailableReservationDates AS
SELECT c.[Name] Campsite, rd.reservationDates AvailableDates
FROM Projects.dbo.Campsite c INNER JOIN Projects.dbo.ReservationDates rd
ON c.campsiteId = rd.campsiteId
WHERE rd.reservedBy = 0
GO

--Create Function
IF object_id(N'GetMostPopularDayToVisit', N'IF') IS NOT NULL
    DROP FUNCTION GetMostPopularDayToVisit
GO

CREATE FUNCTION GetMostPopularDayToVisit()
RETURNS TABLE
AS RETURN
WITH cte
AS
(
	SELECT TOP 1 reservationDates AS ReservationDate, SUM(totalVisitors) AS TotalVisitors
	FROM ReservationDates
	GROUP BY reservationDates
	ORDER BY TotalVisitors DESC
)
SELECT ReservationDate, TotalVisitors
FROM cte
GO