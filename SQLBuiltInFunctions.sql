USE SoftUni

--Create an SQL query that finds all employees whose first name starts with "Sa". As a result, display "FirstName" and "LastName"
SELECT FirstName,LastName 
FROM Employees
WHERE LEFT(FirstName,2)='Sa'

--Create an SQL query that finds all employees whose last name contains "ei". As a result, display "FirstName" and "LastName"
SELECT FirstName,LastName
FROM Employees
WHERE LastName LIKE '%ei%'

--Create an SQL query that finds the first names of all employees which department ID is 3 or 10, and the hire year is between 1995 and 2005 inclusive.
SELECT FirstName
FROM Employees
WHERE DepartmentID IN (3,10) AND DATEPART(YEAR,HireDate) BETWEEN 1995 AND 2005

--Create an SQL query that finds the first and last names of every employee which job titles do not contain "engineer". 
SELECT FirstName,LastName
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'

--Create an SQL query that finds town names 5 or 6 symbols long. Order the result alphabetically by town name.
SELECT [Name]
FROM Towns
WHERE LEN([Name]) IN (5,6)
ORDER BY [Name]

--Create an SQL query that finds all towns with names starting with M, K, B, or E. Order the result alphabetically by town name. 
SELECT *
FROM Towns
WHERE LEFT([Name],1) IN ('M', 'K', 'B', 'E')
ORDER BY [Name]

--Create an SQL query that finds all towns that do not start with R, B, or D. Order the result alphabetically by name.
SELECT *
FROM Towns
WHERE LEFT([Name],1) NOT IN ('R', 'B', 'D')
ORDER BY [Name]

--Create an SQL query that creates view "V_EmployeesHiredAfter2000" with the first and last name for all employees hired after the year 2000. 
CREATE VIEW V_EmployeesHiredAfter2000 
AS
SELECT FirstName,LastName
FROM Employees
WHERE DATEPART(YEAR,HireDate)>2000

--Create an SQL query that finds all employees whose last name is exactly 5 characters long.
SELECT FirstName,LastName
FROM Employees
WHERE LEN(LastName)=5

--Write a query that ranks all employees using DENSE_RANK. In the DENSE_RANK function, employees need to be partitioned by Salary and ordered by EmployeeID.
--You need to find only the employees whose Salary is between 10000 and 50000 and order them by Salary in descending order.

SELECT EmployeeID, FirstName, LastName, Salary, DENSE_RANK() 
		OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000
	ORDER BY Salary DESC

--Find all countries that hold the letter 'A' at least 3 times in their name (case-insensitively).
--Sort the result by ISO code and display the "Country Name" and "ISO Code". 
USE Geography
SELECT [CountryName] AS [Country Name],
       [IsoCode] AS [ISO Code]
FROM Countries
WHERE CountryName LIKE '%A%A%A%'
ORDER BY IsoCode

--Combine all peak names with all river names, so that the last letter of each peak name is the same as the first letter of its corresponding river name.
--Display the peak names, river names, and the obtained mix (mix should be in lowercase).
--Sort the results by the obtained mix.

SELECT PeakName, RiverName, LOWER(SUBSTRING(PeakName, 1, LEN(PeakName) - 1) + RiverName)
		AS Mix 
	FROM Peaks, Rivers
	WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1)
	ORDER BY Mix

--Find and display the top 50 games which start date is from 2011 and 2012 year, ordered by start date, then by name of the game. 
--The start date should be in the following format: "yyyy-MM-dd". 
USE Diablo
SELECT TOP(50)[Name],FORMAT(Start,'yyyy-MM-dd') AS [Start]
FROM Games
WHERE  DATEPART(Year,Start) BETWEEN 2011 AND 2012
ORDER BY Start,[Name]

--Find all users along with information about their email providers. Display the username and email provider.
--Sort the results by email provider alphabetically, then by username. 
SELECT Username,SUBSTRING(Email,CHARINDEX('@',Email)+1,LEN(Email)-1) AS EmailProvider
FROM Users
ORDER BY EmailProvider,Username

--Find all users along with their IP addresses sorted by username alphabetically.
--Display only rows that IP address matches the pattern: "***.1^.^.***". 
SELECT Username,IpAddress
FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username

--Find all games with part of the day and duration sorted by game name alphabetically then by duration (alphabetically, not by the timespan)
--and part of the day (all ascending). Parts of the day should be Morning (time is >= 0 and < 12), 
--Afternoon (time is >= 12 and < 18), Evening (time is >= 18 and < 24). Duration should be Extra Short (smaller or equal to 3),
--Short (between 4 and 6 including), Long (greater than 6) and Extra Long (without duration). 
SELECT [Name],
CASE
		WHEN DATEPART(HOUR, [Start]) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 18 AND 23 THEN 'Evening'
	END AS [Part of the Day],
	CASE
		WHEN Duration <= 3 THEN 'Extra Short'
		WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
		WHEN Duration > 6 THEN 'Long'
		ELSE 'Extra Long'
	END AS Duration
	FROM Games
	ORDER BY [Name], Duration





