/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Id]
      ,[FirstName]
      ,[LastName]
      ,[Notes]
      ,[Age]
      ,[MagicWandCreator]
      ,[MagicWandSize]
      ,[DepositGroup]
      ,[DepositStartDate]
      ,[DepositAmount]
      ,[DepositInterest]
      ,[DepositCharge]
      ,[DepositExpirationDate]
      ,[IsDepositExpired]
  FROM [Gringotts].[dbo].[WizzardDeposits]


  --gurmiiiiiiiiiiiiiii
 SELECT  DepositGroup, SUM(DepositAmount) TotalSum FROM WizzardDeposits
 GROUP BY DepositGroup,MagicWandCreator
 HAVING MagicWandCreator='Ollivander family' AND SUM(DepositAmount)<150000
 ORDER BY TotalSum DESC

 SELECT DepositGroup,MagicWandCreator,MIN(DepositCharge)AS MinDepositCharge FROM WizzardDeposits
 GROUP BY DepositGroup,MagicWandCreator
 ORDER BY MagicWandCreator

SELECT AgeGroup,COUNT(Id) FROM( 
SELECT *,
 CASE 
     WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
	 WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
	 WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
	 WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
	 WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
	 WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
	 ELSE '[61+]'
END AS AgeGroup
FROM WizzardDeposits) AS AgeGroups
GROUP BY AgeGroup


SELECT DISTINCT SUBSTRING(FirstName,1,1) AS FirstLetter 
FROM WizzardDeposits
WHERE DepositGroup='Troll Chest'
GROUP BY DepositGroup,FirstName

SELECT  DepositGroup,IsDepositExpired,AVG(DepositInterest) AS AverageInterest
FROM WizzardDeposits
WHERE DepositStartDate>'01/01/1985'
GROUP BY DepositGroup,IsDepositExpired
ORDER BY DepositGroup DESC,IsDepositExpired ASC

USE SoftUni

SELECT DepartmentID,SUM(Salary) FROM Employees
GROUP BY DepartmentID 
ORDER BY DepartmentID


SELECT DepartmentID,MIN(Salary) AS MinimumSalary 
FROM Employees
WHERE DepartmentID IN(2,5,7) AND HireDate>'01/01/2000'
GROUP BY DepartmentID

SELECT DepartmentID,MAX(Salary) AS MaxSalary
FROM Employees
WHERE Salary NOT BETWEEN 30000 AND 70000
GROUP BY DepartmentID 

SELECT COUNT(*) FROM Employees
WHERE ManagerID IS NULL

SELECT DISTINCT DepartmentID,Salary AS ThirdHighestSalary FROM(
SELECT * ,
DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
FROM Employees) AS k
WHERE SalaryRank=3


--FirstName,LastName,DepartmentID


SELECT TOP(10)FirstName,LastName,DepartmentID 
FROM Employees AS e
WHERE Salary>(
SELECT AVG(Salary) AS AverageSalary 
FROM Employees
WHERE DepartmentID=E.DepartmentID
GROUP BY DepartmentID
)
ORDER BY DepartmentID

















