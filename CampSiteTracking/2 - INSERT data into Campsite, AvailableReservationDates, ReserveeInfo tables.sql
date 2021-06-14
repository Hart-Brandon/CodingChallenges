USE Projects --Change schema name if needed
GO

--INSERT Campsite data
INSERT INTO Campsite (campsiteId, [name])
VALUES
(1, 'Church Fork Campsite'),
(2, 'South Box Elder Campsite'),
(3, 'Big Water Yurt'),
(4, 'Upper Box Elder Campsite'),
(5, 'Terraces Campsite'),
(6, 'Little Cottonwood Canyon'),
(7, 'Big Cottonwood Canyon'),
(8, 'Pony Express RV Resort'),
(9, 'Pony Express Campground')
GO

--INSERT Reservee Data
INSERT INTO Reservee ([name], dob)
VALUES
('Bob Hunt', '1963-11-06'),
('Sam Baker', '1976-02-15'),
('Sherry Fisher', '1982-08-27'),
('Carrie Smith', '1990-05-15'),
('Logan Butcher', '1988-03-17'),
('William Turner', '1958-05-22'),
('Lauren Smith', '1964-06-30'),
('Josh Kelly', '1974-08-02'),
('Alex Jones', '1985-11-13'),
('Robert Flint', '1982-01-09'),
('Kelly Hooke', '1974-12-13')
GO

--INSERT ReservationDates data--
DECLARE @start_date DATE,
        @end_date DATE,
		@reserved_by INT,
		@visitors INT,
		@index INT

SET @visitors = 0
SET @index = 1

WHILE @index <= 9
BEGIN
	IF (@index <= 3)
	BEGIN
		SET @start_date = '2021-12-01'
		SET @end_date = '2022-03-31'
	END
	ELSE IF(@index <= 6)
	BEGIN
		SET @start_date = '2021-12-01'
		SET @end_date = '2022-04-30'
	END
	ELSE
	BEGIN
		SET @start_date = '2021-07-01'
		SET @end_date = '2021-09-30'
	END

	WHILE @start_date <= @end_date
	BEGIN	
		SET @visitors = 0
		SET @reserved_by = 12 * RAND() + 0 --NULLIF(12 * RAND() + 0, 0)
		
		IF (@reserved_by > 0)
		BEGIN
			SET @visitors = 15 * RAND() + 0 --NULLIF(15 * RAND() + 0, 0)
		END
	
		INSERT INTO ReservationDates (campsiteId, reservationDates, reservedBy, totalVisitors)
		VALUES (@index, @start_date, @reserved_by, @visitors)
	
		SET @start_date = DATEADD(Day, 1, @start_date)
	END

	SET @index = @index + 1
END
GO