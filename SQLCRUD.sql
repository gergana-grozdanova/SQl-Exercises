SELECT [Name] FROM [Departments]
SELECT [FirstName],[MiddleName],[LastName] FROM [Employees]
SELECT [FirstName]+'.'+[LastName]+'@softuni.bg' FROM [Employees] AS ["Full Email Address"]
SELECT DISTINCT [Salary] FROM [Employees] 
SELECT * FROM [Employees] WHERE [JobTitle]='Sales Representative'
SELECT [FirstName],[LastName],[JobTitle] FROM [Employees] WHERE [Salary] BETWEEN 20000	AND 30000

--Create an SQL query that finds the full name of all employees whose salary is exactly 25000, 14000, 12500, or 23600. The result should be displayed in a column named "Full Name", which is a combination of first, middle, and last names separated by a single space.
SELECT [FirstName]+' '+[MiddleName]+' '+[LastName] as [Full Name] FROM [Employees] WHERE ([Salary] = 25000 or  [Salary] = 12500 or [Salary] = 14000 or[Salary] = 23600 )

--Create an SQL query that finds the first and last names of those employees that do not have a manager. 
SELECT [FirstName],[LastName] FROM Employees WHERE ([ManagerID] IS NULL)

--Create an SQL query that finds the first name, last name, and salary for employees with a salary higher than 50000. Order the result in decreasing order by salary. 
SELECT [FirstName],[LastName],[Salary] FROM [Employees] WHERE [Salary]>50000 ORDER BY [Salary] DESC

--Create an Write a SQL query that sorts all records in the Employees table by the following criteria: 
--•	By salary in decreasing order
--•	Then by the first name alphabetically
--•	Then by the last name descending
--•	Then by middle name alphabetically
SELECT * FROM [Employees]
ORDER BY [Salary]DESC,[FirstName]ASC,[LastName]DESC,[MiddleName]ASC

--Create an SQL query that finds the first and last names of the 5 best-paid Employees, ordered in descending by their salary.
SELECT TOP(5)[FirstName],[LastName] FROM [Employees] ORDER BY [Salary] DESC

--Create an SQL query that creates a view "V_EmployeesSalaries" with first name, last name, and salary for each employee.
CREATE VIEW [V_EmployeesSalaries] AS (
SELECT [FirstName],[LastName],[Salary] FROM [Employees]
)

--Create an SQL query to create view "V_EmployeeNameJobTitle" with full employee name and job title. When the middle name is NULL replace it with an empty string ('').
CREATE VIEW [V_EmployeeNameJobTitle] AS (
SELECT CONCAT([FirstName],' ',ISNULL([MiddleName],''),' ',[LastName])AS [FullName],[JobTitle] FROM [Employees]
)

---Create an SQL query that finds�all distinct job titles.
SELECT DISTINCT [JobTitle] FROM [Employees]

--Create an SQL query that finds the first 10 projects which were started, select all information about them, and sort the result by starting date, then by name.
SELECT TOP(10) * FROM [Projects] ORDER BY [StartDate] ASC,[Name] 

--Create an SQL query that finds the last 7 hired employees, select their first, last name, and hire date.
SELECT TOP(7) [FirstName],[LastName],[HireDate] FROM [Employees] ORDER BY[HireDate] DESC

--Create an SQL query that increases salaries by 12% of all employees that work in the ether Engineering, Tool Design, Marketing, or Information Services departments.
--As a result, select and display only the "Salaries" column from the Employees table. After that exercise, you should restore the database to the original data.

UPDATE [Employees] 
SET [Salary]+=[Salary]*0.12
WHERE [DepertmentID] IN (1,2,4,11)

SELECT [Salary] FROM [Employees]

--Display all mountain peaks in alphabetical order.
SELECT [PeakName] FROM [Peaks] ORDER BY [PeakName] ASC

--Find the 30 biggest countries by population located in Europe. Display the "CountryName" and "Population".
--Sort the results by population (from biggest to smallest), then by country alphabetically.

SELECT TOP(30)[CountryName],[Population] 
FROM [Countries] 
WHERE  [ContinentCode]='EU'
ORDER BY [Population] DESC,[CountryName]ASC

--Find all countries along with information about their currency. Display the "CountryName", "CountryCode", 
--and information about its "Currency": either "Euro" or "Not Euro". Sort the results by country name alphabetically.

SELECT [CountryName],[CountryCode], 
CASE 
    WHEN [CurrencyCode] ='EUR' THEN'Euro'
	ELSE 'Not Euro'
END AS [Currency]
FROM [Countries]
ORDER BY [CountryName]