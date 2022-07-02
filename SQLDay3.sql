-- 1.
SELECT distinct(C.City)
From Customers C
WHERE C.City in (Select E.City From Employees E);

-- 2.
SELECT distinct(C.City)
From Customers C
WHERE C.City not in(Select distinct(E.City) From Employees E);

SELECT distinct(C.City)
From Customers C
EXCEPT
Select E.City From Employees E
GROUP By City
HAVING count(*) = 1;

SELECT * from [Order Details]
-- 3.
SELECT p.ProductName, ot.NumQuantity
 from Products p 
 LEFT JOIN 
 (Select od.ProductID,SUM(od.Quantity) as [NumQuantity] 
 from [Order Details] od 
 GROUP by od.ProductID ) ot
 ON ot.ProductID = p.ProductID;

--4.
SELECT ShipCity, Sum(ot.Quantity) [NumQuantity]
from Orders o inner JOIN
(Select od.OrderID, od.Quantity
from [Order Details] od ) ot
ON o.OrderID = ot.OrderID
GROUP by o.ShipCity

-- 5.
SELECT City from Customers
EXCEPT 
SELECT City from Customers
GROUP by City
HAVING COUNT(*) = 1;

SELECT City From 
(Select * From Customers) 
group by City 
HAVING COUNT(*)>= 2;

--6.
select distinct(OrderID) from [Order Details] 
WHERE OrderID IN(
SELECT OrderID,COUNT(distinct(ProductID))
from [Order Details]
 GROUP by OrderID 
 HAVING COUNT(distinct(ProductID))  >1);

 --7
 SELECT distinct(ShipCity)
 From Orders
 WHERE ShipCity not in 
 (Select City
 from Customers);

 --8.
SELECT Top 5 Avg(Ot.UnitPrice)[TheAvg],ot.ProductID,ShipCity
from Orders o inner JOIN(
SELECT OrderID, ProductId, Quantity,UnitPrice
from [Order Details]) ot
ON o.OrderID = ot.OrderID
GROUP by ShipCity,ot.ProductID
ORDER BY Sum(ot.Quantity) DESC

--9.
SELECT City from Employees
WHERE City not in (Select ShipCity From Orders);

Select E.City From Employees E
GROUP By E.City
EXCEPT
SELECT distinct(ShipCity)
From Orders

-- 10.

SELECT top 1 ord.ShipCity from(
SELECT  count(OrderID) [TheCount],ShipCity 
from Orders GROUP by ShipCity ) ord
inner JOIN
(
SELECT ShipCity, Sum(ot.Quantity) [NumQuantity]
from Orders o inner JOIN
(Select od.OrderID, od.Quantity
from [Order Details] od ) ot
ON o.OrderID = ot.OrderID
GROUP by o.ShipCity
) ord2
on ord.ShipCity = ord2.ShipCity
order BY  ord2.NumQuantity desc, ord.TheCount 

--11.
-- We can use count(*) with having to select the result which occurrence equals 1.
-- like question 2's answer i used HAVING COUNT(*) = 1;

