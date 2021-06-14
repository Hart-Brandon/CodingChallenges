USE Projects --Change schema name if needed
GO

--CREATE Campsite table
IF EXISTS (SELECT 1 FROM sysobjects WHERE name='ReservationDates' and xtype='U')
BEGIN
	ALTER TABLE ReservationDates
	DROP CONSTRAINT FK_ReservationDates_CampsiteId
END
GO

DROP TABLE IF EXISTS Campsite
GO

CREATE TABLE Campsite
(
	campsiteId INT NOT NULL,
	[name] VARCHAR(MAX) NOT NULL,
	CONSTRAINT PK_CampsiteId PRIMARY KEY (campsiteId)
)
GO

--CREATE Reservee table
DROP TABLE IF EXISTS Reservee
GO

CREATE TABLE Reservee
(
	reserveeId INT NOT NULL IDENTITY,
	[name] VARCHAR(MAX),
	dob DATE NOT NULL
	CONSTRAINT PK_ReserveeId PRIMARY KEY (reserveeId)
)
GO

--CREATE ReservationDates table
DROP TABLE IF EXISTS ReservationDates
GO

CREATE TABLE ReservationDates
(
	reservationDatesId INT NOT NULL IDENTITY,
	campsiteId INT NOT NULL,
	reservationDates DATE NOT NULL,
	reservedBy INT NULL,
	totalVisitors INT NULL
	CONSTRAINT PK_ReservationDatesId PRIMARY KEY (reservationDatesId),
	CONSTRAINT FK_ReservationDates_CampsiteId FOREIGN KEY (campsiteId) REFERENCES Campsite(campsiteId)
)
GO