#!/bin/bash

DROP DATABASE qr;
CREATE DATABASE qr /*!40100 DEFAULT CHARACTER SET utf8 */;
CREATE USER IF NOT EXISTS pi@localhost IDENTIFIED BY "mitUnix06"; 
GRANT ALL PRIVILEGES ON qr.* TO pi@localhost IDENTIFIED BY "mitUnix06";

CREATE TABLE qr.users (userID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	firstName VARCHAR(30) NOT NULL,
	lastName VARCHAR(30) NOT NULL,
	middleName VARCHAR(30) NOT NULL,
	studNum VARCHAR(10) NOT NULL,
	email VARCHAR(50) NOT NULL);

CREATE TABLE qr.schedule (schID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	schStart DATE NOT NULL,
	schEnd DATE NOT NULL,
	day VARCHAR(9) NOT NULL,
	dayStart TIME NOT NULL,
	dayEnd TIME NOT NULL);

CREATE TABLE qr.userSchedRelation (userID INT NOT NULL, 
	schID INT NOT NULL,
	FOREIGN KEY (userID) REFERENCES qr.users(userID),
	FOREIGN KEY (schID) REFERENCES qr.schedule(schID));


DELIMITER //
CREATE PROCEDURE  qr.spUSR()
BEGIN
	SELECT u.userID,s.schID,u.firstName,s.schStart,s.schEnd,s.day,s.dayStart,s.dayEnd
		FROM qr.users u 
		INNER JOIN qr.userSchedRelation usr on u.userID = usr.userID 
		INNER JOIN qr.schedule s on s.schID = usr.schID;
	INSERT INTO qr.users (firstName,lastName,middleName,studNum,email) VALUES ("ay","lmao","gg","111","adsf@mail.com");
END//
DELIMITER ;

CALL qr.spUSR();
