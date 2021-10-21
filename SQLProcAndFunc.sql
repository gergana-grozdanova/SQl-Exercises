CREATE OR ALTER PROC usp_GetEmployeesSalaryAbove35000 AS 
SELECT FirstName,LastName FROM Employees
WHERE Salary>35000

EXEC usp_GetEmployeesSalaryAbove35000

CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber
(@num DECIMAL(18,4)) AS
SELECT FirstName,LastName FROM Employees
WHERE Salary>=@num

EXEC usp_GetEmployeesSalaryAboveNumber 4000

CREATE OR ALTER PROC usp_GetTownsStartingWith(@str VARCHAR(10)) AS 
SELECT [Name] FROM Towns
WHERE LEFT([Name],LEN(@str))=@str

EXEC usp_GetTownsStartingWith Nev

CREATE PROC usp_GetEmployeesFromTown (@town VARCHAR(50)) AS
SELECT FirstName,LastName FROM Employees AS e
JOIN Addresses AS a
ON e.AddressID=a.AddressID
JOIN Towns AS t
ON t.TownID=a.TownID
WHERE t.[Name]=@town

EXEC usp_GetEmployeesFromTown Nevada

CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4)) 
RETURNS VARCHAR(7)
AS
BEGIN
DECLARE @SalaryLevel VARCHAR(7)
    IF (@salary<30000)
	SET @SalaryLevel = 'Low'
	ELSE IF (@salary<=50000 )
	SET @SalaryLevel = 'Average'
	ELSE 
	SET @SalaryLevel='High'
RETURN @SalaryLevel
END;

CREATE PROC usp_EmployeesBySalaryLevel @level VARCHAR(7)
AS 
SELECT FirstName,LastName 
FROM Employees
WHERE dbo.ufn_GetSalaryLevel(Salary)=@level

GO
CREATE OR ALTER FUNCTION ufn_IsWordComprised(@setOfLetters NVARCHAR(MAX), @word NVARCHAR(MAX)) 
RETURNS BIT
AS 
BEGIN
DECLARE @i int = 1
WHILE @i <=LEN(@word)
BEGIN
    DECLARE @currLetter CHAR(1)=SUBSTRING(@word,@i,1)
	DECLARE @index INT = CHARINDEX(@currLetter,@setOfLetters)
	IF @index=0
	RETURN 0
    SET @i = @i + 1
END
RETURN 1
END 
GO




CREATE PROC usp_DeleteEmployeesFromDepartment(@departmentId INT) AS
BEGIN

DELETE FROM EmployeesProjects
       WHERE EmployeeID IN(
       SELECT EmployeeID FROM Employees
       WHERE DepartmentID=@departmentId
       )

UPDATE Employees
SET ManagerID=NULL
WHERE ManagerID IN(
       SELECT EmployeeID FROM Employees
       WHERE DepartmentID=@departmentId
       )

ALTER TABLE Departments
ALTER COLUMN ManagerId INT 


UPDATE Departments
SET ManagerID =NULL
WHERE ManagerID IN(
       SELECT EmployeeID FROM Employees
       WHERE DepartmentID=@departmentId
       )

DELETE Employees
WHERE DepartmentID=@departmentId

DELETE Departments
WHERE DepartmentID=@departmentId
END


--9
CREATE PROC usp_GetHoldersFullName AS
BEGIN
SELECT CONCAT(FirstName,' ',LastName) AS [Full Name]FROM AccountHolders
END


--10
GO
CREATE PROC usp_GetHoldersWithBalanceHigherThan(@number INT) AS
BEGIN
SELECT FirstName,LastName FROM AccountHolders AS ah
JOIN Accounts AS a ON ah.Id=a.AccountHolderId
WHERE Balance>@number
ORDER BY FirstName,LastName
END

--11
GO
CREATE OR ALTER FUNCTION ufn_CalculateFutureValue (@sum DECIMAL,@yearlyInterestRate FLOAT,@numberOfYears INT)
RETURNS DECIMAL(18,4) AS
BEGIN
RETURN @sum*POWER(1+@yearlyInterestRate,@numberOfYears)
END

GO
 SELECT  dbo.ufn_CalculateFutureValue(1000, 0.1, 5)

 --12
 GO
 CREATE PROC usp_CalculateFutureValueForAccount AS
 BEGIN
 SELECT * FROM 

 END








