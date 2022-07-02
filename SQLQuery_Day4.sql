-- 1.
CREATE VIEW [view_product_order_Mingxi Yan] AS
SELECT P.ProductID,p.ProductName,SUM(OD.Quantity)[TheQuantity]
from [Order Details] OD
INNER Join Products P
on OD.ProductID = p.ProductID
GROUP BY P.ProductID,p.ProductName


SELECT SUM(Quantity) From [Order Details] WHERE ProductID = 1
-- 2.
CREATE PROCEDURE [sp_product_order_quantity_Mingxi_Yan]
@pid int,
@totalQuantity int OUT
As
BEGIN
   SELECT @totalQuantity =  SUM(Quantity) From [Order Details] WHERE ProductID = @pid
END

Begin
	Declare @totalQuantity int 
	exec sp_product_order_quantity_Mingxi_Yan 1, @totalQuantity OUT
	Select @totalQuantity
End

--3.

create proc sp_product_order_city_Mingxi_Yan
@pname varchar(100)
as 
BEGIN
SELECT t1.ProductName, t1.ShipCity, t1.TheQuantity, t2.TheCount FROM
(SELECT top 5 o1.ShipCity, od1.ProductID, p.ProductName,SUM(od1.Quantity) [TheQuantity] FROM Orders o1
inner JOIN [Order Details] od1 on o1.OrderID = od1.OrderID
INNER join Products p on od1.ProductID = p.ProductID
GROUP BY o1.ShipCity,od1.ProductID,p.ProductName
ORDER by Sum(od1.Quantity) DESC) t1
LEFT JOIN(
SELECT * from (SELECT rs.ProductName, rs.ProductID, rs.ShipCity,rs.TheCount, rank() over(partition by
productid order by [TheCount] desc) [rk] from
(select p.ProductID,p.ProductName, o.ShipCity, count(od.OrderID) [TheCount] from Orders o
LEFT JOIN [Order Details] od ON o.OrderID=od.OrderID
LEFT JOIN Products p ON od.ProductID=p.ProductID
GROUP BY p.ProductID, o.ShipCity,p.ProductName) rs ) rsck WHERE rsck.rk=1)t2
ON t1.ProductID = t2.ProductID
WHERE t1.ProductName = @pname

end;

--4.

CREATE TABLE city_Mingxi_Yan(
    cid int PRIMARY key,
    cname varchar(50)
);

Insert into  city_Mingxi_Yan (cid, cname) VALUES(1, 'Seattle'),(2, 'Green Bay');

create table people_Mingxi_Yan(
    pid int PRIMARY key,
    pname varchar(60),
    cid int ,
    FOREIGN key(cid) REFERENCES city_Mingxi_Yan(cid)
);

INSERT into people_Mingxi_Yan (pid, pname, cid) VALUES (1,'Aaron Rodgers',2),(2,'Russell Wilson',1),(3,'Jody Nelson',2);


UPDATE city_Mingxi_Yan set cname = 'Madison' WHERE  cname = 'Seattle'

Create view Packers_Mingxi_Yan
as SELECT pname from people_Mingxi_Yan p
WHERE p.cid in (Select cid from city_Mingxi_Yan where cname = 'Green Bay');

DROP view Packers_Mingxi_Yan
Drop TABLE people_Mingxi_Yan
drop TABLE city_Mingxi_Yan 

-- 5.
CREATE PROC sp_birthday_employees_Mingxi_Yan
as
begin
SELECT * into birthday_employees_Mingxi_Yan from
Employees
where month(BirthDate)=2
end


EXEC sp_birthday_employees_Mingxi_Yan
drop table birthday_employees_Mingxi_Yan

DELETE FROM birthday_employees_Mingxi_Yan

--6. 
-- You can also use the 'Except' keyword in SQL Server.

SELECT Col1, Col2, Col3, Col4, Col5 FROM Table_1
EXCEPT
SELECT Col1, Col2, Col3, Col4, Col5 FROM Table_2