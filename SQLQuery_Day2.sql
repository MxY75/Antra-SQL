
-- 1.
SELECT COUNT(ProductId) [#Product] FROM Production.Product;

-- 2.
SELECT count(ProductID) [#Inclued In Subcategory]
from Production.Product
WHERE ProductSubcategoryID is not null;

-- 3.
SELECT  ProductSubcategoryID,COUNT(ProductID) 'CountedProducts'
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP by ProductSubcategoryID;

-- 4.
SELECT ProductSubcategoryID,COUNT(ProductID) 'CountedProducts'
FROM Production.Product
WHERE ProductSubcategoryID IS  NULL
GROUP by ProductSubcategoryID;


-- 5.
SELECT ProductId,SUM(Quantity) [Product Quantity]
From Production.ProductInventory 
GROUP by ProductID;

-- 6.
SELECT ProductId,SUM(Quantity) [TheSUM]
From Production.ProductInventory 
WHERE LocationID = 40
GROUP by ProductID
HAVING SUM(Quantity) < 100;

-- 7.
SELECT Shelf,ProductID,SUM(Quantity) [TheSUM]
From Production.ProductInventory 
WHERE LocationID = 40
GROUP by Shelf,ProductId
HAVING SUM(Quantity) < 100;

-- 8.
SELECT AVG(Quantity) [The AVG Quantity of 10]
FROM Production.ProductInventory
WHERE LocationID = 10;

-- 9.
SELECT ProductID, Shelf, AVG(Quantity)[TheAvg]
FROM Production.ProductInventory
GROUP by ProductID, Shelf;

-- 10.
SELECT ProductID, Shelf, AVG(Quantity)[TheAvg]
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP by ProductID, Shelf;


-- 11.
SELECT Color, Class,COUNT(ProductID)[TheCount],AVG(ListPrice)[TheAvg]
From Production.Product
WHERE Color is not NULL and Class is not NULL
GROUP BY Color,Class

-- 12.
SELECT CR.Name Country, SP.NAME Province
from person.CountryRegion CR
INNER JOIN  Person.StateProvince SP
ON CR.CountryRegionCode = SP.CountryRegionCode;

-- 13.

SELECT CR.Name Country, SP.NAME Province
from person.CountryRegion CR
INNER JOIN  Person.StateProvince SP
ON CR.CountryRegionCode = SP.CountryRegionCode
WHERE CR.Name = 'Canada' or CR.Name = 'Germany';

-- Using Northwnd Database
Use Northwind
-- 14. 
SELECT distinct (P.ProductID), P.ProductName
From Products P
inner join [Order Details] OD 
on P.ProductID = OD.ProductID
INNER JOIN Orders O
on O.OrderID  = OD.OrderID
WHERE O.OrderDate > '1997-6-30';

--15.
SELECT top 5 O.ShipPostalCode,SUM(OD.Quantity) [TheSum]
from [Order Details] OD
inner join Orders O
 On OD.OrderID = O.OrderID
 GROUP by O.ShipPostalCode
 Order by SUM(OD.Quantity) desc;

--16.  
SELECT top 5 O.ShipPostalCode,SUM(OD.Quantity) [TheSum]
from [Order Details] OD
inner join Orders O
 On OD.OrderID = O.OrderID
  WHERE O.OrderDate > '1997-6-30'
 GROUP by O.ShipPostalCode
 Order by SUM(OD.Quantity) desc;

-- 17.
SELECT ShipCity,COUNT(Distinct(CustomerID)) [TheCount]
FROM Orders 
Group BY ShipCity;

--18.
SELECT ShipCity,COUNT(Distinct(CustomerID)) [TheCount]
FROM Orders 
Group BY ShipCity
HAVING COUNT(Distinct(CustomerID)) > 2;


--19.
SELECT distinct( C.ContactName)
from Customers C
INNER JOIN Orders O
on O.CustomerID = C.CustomerID
WHERE O.OrderDate > '1998-1-1';

--20.
SELECT distinct( C.ContactName), Max(O.OrderDate)
from Customers C
INNER JOIN Orders O
on O.CustomerID = C.CustomerID
GROUP by C.ContactName;


--21.
SELECT C.ContactName, sum(OD.Quantity) [TheSum]
from [Order Details] OD
INNER JOIN Orders O on OD.OrderID = O.OrderID
INNER JOIN Customers C on C.CustomerID = O.CustomerID
GROUP by C.ContactName;

--22.
SELECT C.ContactName, sum(OD.Quantity) [TheSum]
from [Order Details] OD
INNER JOIN Orders O on OD.OrderID = O.OrderID
INNER JOIN Customers C on C.CustomerID = O.CustomerID
GROUP by C.ContactName
HAVING sum(OD.Quantity) > 100;

-- 23.

SELECT  distinct(sh.[CompanyName]) [Shipping Company Name],su.CompanyName [Supplier Company Name]
from Suppliers su
INNER JOIN Products p
ON p.SupplierID = su.SupplierID
inner JOIN [Order Details] od
on p.ProductID = od.ProductID
INNER join Orders o
on o.OrderID = od.OrderID
INNER JOIN Shippers sh
on sh.ShipperID = o.ShipVia

--24.
SELECT o.OrderDate,p.ProductName
From Orders o
inner JOIN [Order Details] od 
on o.OrderID = od.OrderID
INNER join Products p
on p.ProductID = od.ProductID
ORDER by o.OrderDate

SELECT * from Employees

--25.
SELECT e1.FirstName +' '+ e1.LastName[FullName1],e2.FirstName +' '+ e2.LastName[FullName2]
From Employees e1, Employees e2
WHERE e1.Title = e2.Title
and e1.EmployeeID <> e2.EmployeeID

-- 26.
SELECT COUNT(*) [TheCount], e2.EmployeeID, e2.FirstName +' '+e2.LastName [ManagerName]
From Employees e1
inner join  Employees e2 on e1.ReportsTo = e2.EmployeeID
GROUP BY e2.EmployeeID ,e2.FirstName +' '+e2.LastName
HAVING COUNT(*) > 2;

-- 27.
select City, ContactName, 'Customer'[Type] from Customers
UNION ALL
SELECT City, ContactName, 'Suppliers'[Type] From Suppliers;