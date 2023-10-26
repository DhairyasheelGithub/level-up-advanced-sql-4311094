SELECT sql
FROM sqlite_schema
WHERE name='sales'

GO 

SELECT * 
FROM sales;

GO 
SELECT 
emp.firstName,
emp.lastName,
emp.title,
sls.soldDate,
MIN(sls.salesAmount) AS minSales,
MAX(sls.salesAmount) AS maxSales
FROM sales as sls 
INNER JOIN employee as emp 
on sls.employeeId = emp.employeeId
WHERE sls.soldDate >= date('now','start of year')
GROUP BY emp.employeeId,emp.firstName,emp.lastName

GO 

SELECT 
emp.firstName,
emp.lastName,
emp.title,
sls.soldDate,
count(*) as countNumCars,
MIN(sls.salesAmount) AS minSales,
MAX(sls.salesAmount) AS maxSales
FROM sales as sls 
INNER JOIN employee as emp 
on sls.employeeId = emp.employeeId
WHERE sls.soldDate >= date('now','start of year')
GROUP BY emp.employeeId
HAVING count(*) > 5;

GO 
WITH ctc AS ( 
SELECT strftime ('%Y', soldDate) AS soldYear,
salesAmount
FROM
sales )
SELECT soldYear,
FORMAT ("$%,2f", sum(salesAmount)) as annualSales
FROM ctc 
GROUP BY soldYear
ORDER BY soldYear

GO 
