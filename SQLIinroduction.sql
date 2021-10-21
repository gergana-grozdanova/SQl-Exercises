CREATE DATABASE [Minions]

--2
USE [Minions]

CREATE TABLE [Minions](
[Id] INT NOT NULL,
[Name] NVARCHAR(30) NOT NULL,
[Age] INT,
)

ALTER TABLE [Minions]
ADD CONSTRAINT PK_MinionsId PRIMARY KEY (Id)


USE [Minions]
CREATE TABLE [Town](
[Id] INT PRIMARY KEY NOT NULL,
[Name] NVARCHAR(30) NOT NULL,
)

--3

ALTER TABLE [Minions]
ADD [TownId] INT

ALTER TABLE [Minions]
ADD CONSTRAINT [FK_MinionsTownId] FOREIGN KEY (TownId) REFERENCES [Town]([Id])

--4
INSERT INTO [Towns]([Id],[Name]) VALUES
(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna')

INSERT INTO [Minions] ([Id],[Name],[Age],[TownId]) VALUES
(1,'Kevin',22,1),
(2,'Bob',15,3),
(3,'Steward',NULL,2)

--5 trie danni ot tazi tablica
TRUNCATE TABLE [Minions]

--7
USE [Minions]
CREATE TABLE [People](
[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL ,
[Name] NVARCHAR(200) NOT NULL,
[Picture] VARBINARY(MAX) ,
CHECK (DATALENGTH([Picture])<=2000000),
[Height] DECIMAL (2),
[Weight] DECIMAL (2),
[Gender] NVARCHAR(1) NOT NULL,
[Birthdate] DATE NOT NULL,
[Biography] NVARCHAR(MAX)
)

INSERT INTO [People] ([Name],[Gender],[Birthdate]) VALUES
('A','f','09.06.1995'),
('A','f','09.06.1995'),
('A','f','09.06.1995'),
('A','f','09.06.1995'),
('A','f','09.06.1995')

--8
CREATE TABLE [Users](
[Id] BIGINT IDENTITY(1,1) PRIMARY KEY NOT NULL ,
[Userame] VARCHAR(30) UNIQUE NOT NULL,
[Password] NVARCHAR(26) NOT NULL,
[ProfilePicture] VARBINARY(MAX) ,
CHECK (DATALENGTH([ProfilePicture])<=900000),
[LastLoginTime] DATETIME2,
[IsDeleted] BIT NOT NULL
)

INSERT INTO [Users]([Userame],[Password],[IsDeleted])VALUES
('A','123',0),
('B','123',0),
('D','123',1),
('C','123',1),
('E','123',0)

--9
ALTER TABLE [Users]
DROP CONSTRAINT [PK__Users__3214EC07415E9F07]

ALTER TABLE [Users]
ADD CONSTRAINT [PK_UsersCompositeIdUsername] PRIMARY KEY ([Id],[Userame])

--13
CREATE DATABASE [Movies]

CREATE TABLE [Directors](
[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
[DirectorName] NVARCHAR(30) NOT NULL,
[Notes] NVARCHAR(MAX),
)

CREATE TABLE [Genres](
[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
[GenreName] NVARCHAR(30) NOT NULL,
[Notes] NVARCHAR(MAX),
)

CREATE TABLE [Categories](
[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
[CategoryName] NVARCHAR(30) NOT NULL,
[Notes] NVARCHAR(MAX),
)

CREATE TABLE [Movies](
[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
[Title] NVARCHAR(30) NOT NULL,
[DirectorId] INT FOREIGN KEY REFERENCES [Directors]([Id]),
[CopyrightYear] DATETIME2,
[Length] TIME,
[GenreId] INT FOREIGN KEY REFERENCES [Genres]([Id]),
[CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]),
[Rating] TINYINT,
[Notes] NVARCHAR(MAX)
)

INSERT INTO Directors([DirectorName],Notes) VALUES
('Georgi','georgiNote'),
('Maria','mariaNote'),
('Ivan','ivanNote'),
('Pesho','peshoNote'),
('Marin','marinNote')

INSERT INTO Genres([GenreName],Notes) VALUES 
('Trailer','georgiNote'),
('Horror','mariaNote'),
('Action','ivanNote'),
('Comedy','peshoNote'),
('Anime','marinNote')

INSERT INTO Categories([CategoryName],Notes) VALUES 
('Teen','georgiNote'),
('Creampie','mariaNote'),
('Blowjob','ivanNote'),
('Pronebone','peshoNote'),
('BBC','marinNote')


INSERT INTO Movies([Title],[DirectorId],[CopyrightYear],[Length],[GenreId],[CategoryId],[Rating],[Notes]) VALUES 
('War1',1,'01.02.2005','01:30:33',1,1,'5','Awesome'),
('War2',2,'02.02.2005','01:10:33',2,2,'2','Awesome'),
('War3',5,'03.02.2005','01:20:33',5,5,'1','Awesome'),
('War4',3,'04.02.2005','01:50:33',3,3,'3','Awesome'),
('War5',4,'05.02.2005','01:40:33',4,4,'2','Awesome')

--14
CREATE DATABASE[CarRental]

CREATE TABLE[Categories](
[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
[CategoryName] NVARCHAR(30),
[DailyRate] DECIMAL(9, 2),
[WeekLyRate] DECIMAL(9, 2),
[MonthlyRate] DECIMAL(9, 2),
[WeekendRate] DECIMAL(9, 2),
)

CREATE TABLE Cars (
[Id] INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
[PlateNumber] NVARCHAR(10) NOT NULL,
[Manufacturer] NVARCHAR(20) NOT NULL,
[Model] NVARCHAR(20) NOT NULL,
[CarYear] INT NOT NULL,
[CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]),
[Doors] INT NOT NULL,
[Picture] VARBINARY(MAX),
[Condition] NVARCHAR(MAX),
[Available] BIT 
)

CREATE TABLE Employees (
    [Id] INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [FirstName] NVARCHAR(50) NOT NULL,
    [LastName] NVARCHAR(50) NOT NULL,
    [Title] NVARCHAR(50) NOT NULL,
    [Notes] NVARCHAR(MAX),
)

CREATE TABLE Customers (
    [Id] INT IDENTITY(1, 1)PRIMARY KEY NOT NULL,
    [DriverLicenseNumber] INT NOT NULL,
    [FullName] NVARCHAR(100) NOT NULL,
    [Adress] NVARCHAR(100) NOT NULL,
    [City] NVARCHAR(50) NOT NULL,
    [ZIPCode] INT NOT NULL,
    [Notes] NVARCHAR(MAX),
)

CREATE TABLE RentalOrders (
    [Id] INT IDENTITY(1, 1) PRIMARY KEY,
    [EmployeeId] INT FOREIGN KEY REFERENCES [Employees]([Id]),
    [CustomerId] INT FOREIGN KEY REFERENCES [Customers]([Id]),
    [CarId] INT FOREIGN KEY REFERENCES [Cars]([Id]),
    [TankLevel] INT NOT NULL,
    [KilometrageStart] INT NOT NULL,
    [KilometrageEnd] INT NOT NULL,
    [TotalKilometrage] AS KilometrageEnd - KilometrageStart,
    [StartDate] DATE NOT NULL,
    [EndDate] DATE NOT NULL,
    [TotalDays] AS DATEDIFF(DAY, StartDate, EndDate),
    [RateApplied] DECIMAL(9, 2),
    [TaxRate] DECIMAL(9, 2),
    [OrderStatus] NVARCHAR(50),
    [Notes] NVARCHAR(MAX),

)

INSERT INTO Categories (CategoryName, DailyRate, WeekLyRate, MonthlyRate, WeekendRate) 
     VALUES ('Car', 20, 120, 500, 42.50),
            ('Bus', 250, 1600, 6000, 489.99),
            ('Truck', 500, 3000, 11900, 949.90)

INSERT INTO Cars (PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available) 
     VALUES ('123456ABCD', 'Mazda', 'CX-5', 2016, 1, 5, 123456, 'Perfect', 1),
            ('asdafof145', 'Mercedes', 'Tourismo', 2017, 2, 3, 99999, 'Perfect', 1),
            ('asdp230456', 'MAN', 'TGX', 2016, 3, 2, 123456, 'Perfect', 1)

INSERT INTO Employees (FirstName, LastName, Title, Notes) 
     VALUES ('Ivan', 'Ivanov', 'Seller', 'I am Ivan'),
            ('Georgi', 'Georgiev', 'Seller', 'I am Gosho'),
            ('Mitko', 'Mitkov', 'Manager', 'I am Mitko')

INSERT INTO Customers (DriverLicenseNumber, FullName, Adress, City, ZIPCode, Notes)
     VALUES (123456789, 'Gogo Gogov', 'óë. Ïèðîòñêà 5', 'Ñîôèÿ', 1233, 'Good driver'),
            (347645231, 'Mara Mareva', 'óë. Èâàí Äðàñîâ 14', 'Âàðíà', 5678, 'Bad driver'),
            (123574322, 'Strahil Strahilov', 'óë. Êåñòåí 4', 'Äóïíèöà', 5689, 'Good driver')

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, StartDate, EndDate) 
     VALUES (1, 1, 1, 54, 2189, 2456, '2017-11-05', '2017-11-08'),
            (2, 2, 2, 22, 13565, 14258, '2017-11-06', '2017-11-11'),
            (3, 3, 3, 180, 1202, 1964, '2017-11-09', '2017-11-12')


--15
create table Employees(
Id int primary key identity ,
FirstName varchar(50) not null,
LastName varchar(50) not null,
Title varchar(50)  not null,
Notes varchar(50)
)
create table Customers (
Id int primary key identity ,
AccountNumber smallint,
FirstName varchar(50) not null,
LastName varchar(50) not null,
PhoneNumber smallint ,
EmergencyName varchar(50)not  null,
EmergencyNumber int not null,
Notes varchar(max)
)
create table RoomStatus (
Id int primary key identity,
RoomStatus bit not null,
Notes varchar(max)
)

create table RoomTypes 
(Id int primary key identity,
RoomType varchar(50)not null,
Notes varchar(max)
)
create table BedTypes 
(Id int primary key identity,
BedTypes varchar(50) not null,
Notes varchar(max)
)
create table Rooms (
Id int primary key identity,
RoomNumber tinyint not null,
RoomType int foreign key references RoomTypes(Id),
BedType int foreign key references BedTypes(Id),
Rate smallint not null,
RoomStatus int foreign key references RoomStatus(Id),
Notes varchar(max))

create table Payments (
Id int primary key identity,
EmployeeId int foreign key references Employees(Id),
PaymentDate date ,
AccountNumber tinyint ,
FirstDateOccupied date ,
LastDateOccupied date ,
TotalDays tinyint,
AmountCharged decimal (5,2),
TaxRate decimal (5,2) not null,
TaxAmount decimal (5,2) ,
PaymentTotal decimal (10,2),
Notes varchar(50)
)
create table Occupancies (
Id int primary key identity,
EmployeeId int foreign key references Employees(Id),
DateOccupied date ,
AccountNumber smallint ,
RoomNumber int foreign key references Rooms(id) ,
RateApplied tinyint,
PhoneCharge bit 
,Notes varchar(50))

insert into Employees (FirstName, LastName, Title)
values ('Niki','Nikolov','CEO'),
('Niki','Ivanov','Manager'),
('Niki','Petkov','Chef')

insert into Customers (FirstName, LastName, EmergencyName, EmergencyNumber)
values ('Niki','Niki','Niki','1233210505'),
('Niki3','Niki1','Niki5','1233211505'),
('Niki4','Niki2','Niki6','1233212505')

insert into RoomStatus (RoomStatus)
values (1),(0),(1)

insert into RoomTypes (RoomType)
values ('One'),('Two'),('Three')

insert into BedTypes (BedTypes)
values ('One'),('Two'),('Three')

insert into Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus)

values 
(1,1,1,10,1),
(2,2,2,5,2),
(3,3,3,6,3)

insert into Payments([TaxRate])
values (200.20),
 (220.20),
 (240.20)


insert into Occupancies (Notes)
values ('very good'),
('very g0dd'),
('very bad')


--
select * from [Towns]
select * from Departments
select * from Employees

--
select * from Towns
order by [name] ASC

select * from Departments
order by [name] ASC

select *from Employees
order by [Salary]DESC