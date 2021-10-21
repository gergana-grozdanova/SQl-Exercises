USE SoftUni

SELECT TOP(5)EmployeeID,JobTitle,a.AddressID,AddressText FROM Employees AS e
JOIN Addresses AS a
ON e.AddressID=a.AddressID
ORDER BY a.AddressID

SELECT TOP(50)FirstName,LastName,t.[Name],AddressText FROM Employees AS e
JOIN Addresses AS a
ON e.AddressID=a.AddressID
JOIN Towns AS t
ON t.TownID=a.TownID
ORDER BY e.FirstName,e.LastName



SELECT e.EmployeeID,FirstName,
CASE 
    WHEN DATEPART(YEAR,p.StartDate)>=2005 THEN NULL
	ELSE p.[Name] 
END AS ProjectName
FROM Employees AS e
JOIN EmployeesProjects AS ep
ON e.EmployeeID=ep.EmployeeID
JOIN Projects AS p
ON ep.ProjectID=p.ProjectID
WHERE e.EmployeeID=24

SELECT TOP(50)e.EmployeeID,
CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName,
CONCAT(m.FirstName,' ',m.LastName) AS ManagerName, 
d.[Name] AS DepartmentName
FROM Employees AS e
JOIN Employees AS m
ON e.ManagerID=m.EmployeeID
JOIN Departments AS d
ON d.DepartmentID=e.DepartmentID
ORDER BY e.EmployeeID

SELECT TOP(1) AVG(Salary) AS AverageSalary
	FROM Employees AS e
	JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
GROUP BY e.DepartmentID
ORDER BY AverageSalary


USE Geography

SELECT c.CountryCode,m.MountainRange,p.PeakName,p.Elevation
FROM Countries AS c
JOIN MountainsCountries AS mc
ON c.CountryCode=mc.CountryCode
JOIN Mountains AS m
ON m.Id=mc.MountainId
JOIN Peaks AS p
ON p.MountainId=m.Id
WHERE c.CountryName='Bulgaria' AND p.Elevation>2835
ORDER BY p.Elevation DESC


SELECT c.CountryCode,COUNT(mc.MountainId) AS MountainRanges
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc
ON c.CountryCode=mc.CountryCode
WHERE c.CountryCode IN ('BG','RU','US')
GROUP BY c.CountryCode

SELECT TOP(5)c.CountryName,r.RiverName 
FROM Countries AS c
FULL JOIN CountriesRivers AS cr
ON cr.CountryCode=c.CountryCode
FULL JOIN Rivers AS r
ON cr.RiverId=r.Id
WHERE c.ContinentCode='AF'
ORDER BY c.CountryName

SELECT ContinentCode, CurrencyCode, Total FROM (
SELECT ContinentCode, CurrencyCode, COUNT(CurrencyCode) AS Total,
	DENSE_RANK() OVER(PARTITION BY ContinentCode ORDER BY COUNT(CurrencyCode) DESC) AS Ranked
	FROM Countries
	GROUP BY ContinentCode, CurrencyCode) as k
	WHERE Ranked = 1 AND TOTAL > 1
	ORDER BY ContinentCode


SELECT COUNT(*) AS Count
FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode 
	WHERE mc.MountainId IS NULL


SELECT TOP(5) CountryName, MAX(p.Elevation) AS HighestPeak, MAX(r.Length) AS LongestRiver
FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains AS m ON m.Id = mc.MountainId
	LEFT JOIN Peaks AS p ON p.MountainId = m.Id
	LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
	LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
GROUP BY CountryName
ORDER BY HighestPeak DESC, LongestRiver DESC, CountryName










