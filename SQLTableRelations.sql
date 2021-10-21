--ONE-TO-ONE
CREATE TABLE Passports(
Id INT IDENTITY(101,1) PRIMARY KEY,
PassportNumber CHAR(8),

)

CREATE TABLE Persons(
Id INT IDENTITY  PRIMARY KEY,
FirstName NVARCHAR(30),
Salary DECIMAL(16,2),
PassportID INT UNIQUE FOREIGN KEY REFERENCES Passports(Id)
)

INSERT INTO Passports
VALUES
	('N34FG21B'),
	('K65LO4R7'),
	('ZE657QP2')

INSERT INTO Persons
VALUES
('Roberto', 43300.00, 102),
('Tom', 56100.00, 103),
('Yana', 60200.00, 101)
--ONE-TO-MANY
CREATE TABLE Manufacturers(
ID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(30),
EstablishedOn DATE NOT NULL
)

CREATE TABLE Models(
ID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(30) ,
ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ID)
)

INSERT INTO Manufacturers
VALUES
('BMW',	'07/03/1916'),
('Tesla',	'01/01/2003'),
('Lada',	'01/05/1966')

INSERT INTO Models
VALUES
('X1',	1	 ),
('i6',	1	 ),
('Model S',	2),
('Model X',	2),
('Model 3',	2),
('Nova',	3)
--MANY-TO-MANY
CREATE TABLE Students(
ID INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(30)
)

CREATE TABLE Exams(
ID INT PRIMARY KEY IDENTITY(101,1),
[Name] NVARCHAR(30)
)

CREATE TABLE StudentsExams(
 StudentID INT FOREIGN KEY REFERENCES Students(ID),
 ExamID INT FOREIGN KEY REFERENCES Exams(ID),
 CONSTRAINT [PK_UsersCompositeIdUsername] PRIMARY KEY (StudentID,ExamID)
)

INSERT INTO Students
VALUES
	('Mila'),                                      
	('Toni'),
	('Ron')

INSERT INTO Exams
VALUES
	('SpringMVC'),
	('Neo4j'),
	('Oracle 11g')

INSERT INTO StudentsExams
VALUES
	(1,	101),
	(1,	102),
	(2,	101),
	(3,	103),
	(2,	102),
	(2,	103)

--SELF-REFERENCING
CREATE TABLE Teachers(
ID INT PRIMARY KEY IDENTITY(101,1),
[Name] NVARCHAR(30),
ManagerID INT FOREIGN KEY REFERENCES Teachers(ID)
)

INSERT INTO Teachers
VALUES
	('John',	NULL),
	('Maya',	106	),
	('Silvia',	106	),
	('Ted',		105	),
	('Mark',	101	),
	('Greta',	101	)

--ONLINE DATABASE STORE
CREATE TABLE ItemTypes(
ID INT IDENTITY PRIMARY  KEY,
[Name] VARCHAR(50)
)

CREATE TABLE Items(
ID INT IDENTITY PRIMARY  KEY,
[Name] VARCHAR(50),
ItemTypeID INT FOREIGN KEY REFERENCES ItemTypes(ID)
)

CREATE TABLE Cities(
ID INT IDENTITY PRIMARY  KEY,
[Name] VARCHAR(50)
)

CREATE TABLE Customers(
ID INT IDENTITY PRIMARY  KEY,
[Name] VARCHAR(50),
Birthday DATE ,
CityID INT FOREIGN KEY REFERENCES Cities(ID)
)

CREATE TABLE Orders(
ID INT IDENTITY PRIMARY  KEY,
CustomerID INT FOREIGN KEY REFERENCES Customers(ID)
)

CREATE TABLE OrderItems(
OrderID INT FOREIGN KEY REFERENCES Orders(ID),
ItemID INT FOREIGN KEY REFERENCES Items(ID),
CONSTRAINT [PK_OrderItems] PRIMARY KEY (OrderID,ItemID)
)

--PEAKS IN RILA
Select MountainRange, PeakName,Elevation
FROM PEAKS
JOIN Mountains ON Peaks.MountainId = Mountains.Id
WHERE MountainRange = 'Rila'
ORDER BY Elevation DESC