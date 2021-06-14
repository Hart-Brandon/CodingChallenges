USE Projects

IF (OBJECT_ID('AddReservation','P') IS NOT NULL)
	DROP PROCEDURE dbo.AddReservation;
GO

CREATE PROCEDURE dbo.AddReservation			@totalVisitors INT,
					/*Valid Values: 1-9*/	@campsiteId INT,
				   /*Valid Values: 1-11*/	@reserveeId INT,								
 /*Valid Dates: 2021-07-01 - 2021-09-30*/	@reserveDate DATE
 /*			    2021-12-01 - 2022-04-30*/					
AS 
BEGIN
	SET NOCOUNT ON

	IF ((SELECT reservedBy 
		 FROM ReservationDates 
		 WHERE campsiteId = @campsiteId AND
			   reservationDates = @reserveDate) = 0)
	BEGIN
		UPDATE ReservationDates
		SET reservedBy = @reserveeId,
			totalVisitors = @totalVisitors
		WHERE campsiteId = @campsiteId AND
			  reservationDates = @reserveDate
	END
END
GO