DROP DATABASE IF EXISTS PARTS;
# DROP TABLE IF EXISTS PART; 

CREATE DATABASE PARTS; 

USE PARTS;

CREATE TABLE PART (
    P_ID VARCHAR(10) PRIMARY KEY,
    PNAME VARCHAR(50),
    COLOUR VARCHAR(20),
    WEIGHT INT,
    CITY VARCHAR(50)
);

INSERT INTO PART (P_ID, PNAME, COLOUR, WEIGHT, CITY) VALUES
('P1', 'NUT', 'RED', 12, 'LONDON'),
('P2', 'BOLT', 'GREEN', 17, 'PARIS'),
('P3', 'SCREW', 'BLUE', 17, 'ROME'),
('P4', 'SCREW', 'RED', 14, 'LONDON'),
('P5', 'CAM', 'BLUE', 12, 'PARIS'),
('P6', 'COG', 'RED', 19, 'LONDON');


CREATE TABLE PROJECT(
	J_ID VARCHAR(10) PRIMARY KEY,
    JNAME VARCHAR(50),
    CITY VARCHAR(50)
);

INSERT INTO PROJECT (J_ID, JNAME, CITY) VALUES
('J1', 'SORTER', 'PARIS'),
('J2', 'DISPLAY', 'ROME'),
('J3', 'OCR', 'ATHENS'),
('J4', 'CONSOLE', 'ATHENS'),
('J5', 'RAID', 'LONDON'),
('J6', 'EDS', 'OSLO'),
('J7', 'TAPE', 'LONDON');


CREATE TABLE SUPPLIER (
	S_ID VARCHAR(10) PRIMARY KEY,
    SNAME VARCHAR(10),
    STATUS INT,
    CITY VARCHAR(10)
);

INSERT INTO SUPPLIER (S_ID, SNAME, STATUS, CITY) VALUES
('S1', 'SMITH', 20, 'LONDON'),
('S2', 'JONES', 10, 'PARIS'),
('S3', 'BLAKE', 30, 'PARIS'),
('S4', 'CLARK', 20, 'LONDON'),
('S5', 'ADAMS', 30, 'ATHENS')


SELECT * FROM 