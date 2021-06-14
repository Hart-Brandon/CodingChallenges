USE Projects

IF (OBJECT_ID('CancelReservation','P') IS NOT NULL)
	DROP PROCEDURE dbo.CancelReservation;
GO

CREATE PROCEDURE dbo.CancelReservation
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
			   reservationDates = @reserveDate) = @reserveeId)
	BEGIN
		UPDATE ReservationDates
		SET reservedBy = 0,
			totalVisitors = 0
		WHERE campsiteId = @campsiteId AND
			  reservationDates = @reserveDate
	END
END
GO