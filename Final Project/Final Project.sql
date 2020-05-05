/*create a database*/
use master;
go
if DB_ID (N'FinalProject') is not null
drop database FinalProject;
go
create database FinalProject
go

/*create a non-default schema*/
create schema Milkshakeshop;
go

/*create tables*/
create table Milkshakeshop.Manager(
[ManagerID] INT Primary key identity,
[FirstName] varchar(50),
[LastName] varchar(50),
[Location] varchar(200)
);

CREATE TABLE Milkshakeshop.Employee (
EmpID INT PRIMARY KEY,
EmpFirstName    VARCHAR (50),
EmpLastName    VARCHAR (50),
EmpAddress VARCHAR (200),
EmpPhoneNumber    VARCHAR (22),
EmpHourlyWage    money,
ManagerID INT foreign key references Milkshakeshop.Manager(ManagerID)
);

CREATE TABLE Milkshakeshop.Location (
LocationID VARCHAR (7) PRIMARY KEY, 
LocationName    VARCHAR (100),
EmpID INT FOREIGN KEY REFERENCES Milkshakeshop.Employee (EmpID),
ManagerID INT FOREIGN KEY REFERENCES Milkshakeshop.Manager(ManagerID)
);

CREATE TABLE Milkshakeshop.Product (
ProductID int PRIMARY KEY,
ProductName VARCHAR (50),
ProductSize VARCHAR (50),
ProductFlavor VARCHAR (22),
ProductPrice varchar(20)
);

CREATE TABLE Milkshakeshop.Customer (
CustomerID INT identity (10,1) PRIMARY KEY,
CustomerFirstName VARCHAR (50), 
CustomerLastName VARCHAR (50), 
CustomerEmail VARCHAR (100),
CustomerPhoneNumber VARCHAR (22)
);

CREATE TABLE Milkshakeshop.Orders (
OrderID INT IDENTITY (1,1) PRIMARY KEY, 
OrderDate DATE,
OrderAmount VARCHAR (22),
LocationID VARCHAR (7) FOREIGN KEY REFERENCES Milkshakeshop.Location(LocationID),
ProductID int FOREIGN KEY REFERENCES Milkshakeshop.Product(ProductID),
CustomerID int FOREIGN KEY REFERENCES Milkshakeshop.Customer(CustomerID)
);

/*fix tables*/
alter table Milkshakeshop.Manager
drop column Location;

alter table Milkshakeshop.Manager
add [ContactInfo] varchar(100);

alter table Milkshakeshop.Manager
add [HireDate] date;

alter table Milkshakeshop.Location
add [Address] varchar(200);

alter table Milkshakeshop.Employee
alter column EmpHourlyWage varchar(10);

/*insert data into the tables*/
set identity_insert Milkshakeshop.Manager on
Insert into Milkshakeshop.Manager(ManagerID, FirstName, LastName, ContactInfo, Hiredate)
values
(5, 'Olivia', 'Preston', '452-895-4265', '2010-11-06'),
(1, 'Konner', 'Craig', '714-210-3662', '1999-03-25'),
(14, 'Alex', 'Dawson', '145-695-2110', '2015-12-13'),
(15, 'Ella', 'Bryan', '221-458-3564', '2018-07-30'),
(19, 'Amber', 'Ball', '741-210-3369', '2018-10-01'),
(22, 'David', 'Stone', '321-001-5188', '2019-05-16')
set identity_insert Milkshakeshop.Manager off

/*check manager table*/
select * from milkshakeshop.Manager;

/*insert employee table data*/
insert into Milkshakeshop.Employee(EmpID, ManagerID, EmpFirstName, EmpLastName, EmpAddress, EmpPhoneNumber, EmpHourlyWage)
values
(105, (select ManagerID from Milkshakeshop.Manager where FirstName = 'Ella'), 'Turner', 'Dillon', 'Drario Ave., Colombus, OH', '215-448-6202', '$10.00'),
(121, (select ManagerID from Milkshakeshop.Manager where FirstName = 'Olivia'),'Abby', 'Green', 'Maple dr., Cincinnati, OH', '145-988-2500', '$9.50'),
(130, (select ManagerID from Milkshakeshop.Manager where FirstName = 'Alex'), 'Megan', 'Ross', 'Grand Ave., Cincinnati, OH', '441-520-6945', '$10.25'),
(148, (select ManagerID from Milkshakeshop.Manager where FirstName = 'Amber'), 'Emilia', 'Perry', 'Apple Ave., Cincinnati, OH', '410-892-9954', '$9.25'),
(160, (select ManagerID from Milkshakeshop.Manager where FirstName = 'Konner'), 'Johnny', 'Bulter', 'Green Ave., Chicago, IL', '110-874-6623', '$12.00'),
(161, (select ManagerID from Milkshakeshop.Manager where FirstName = 'Ella'), 'Alex', 'Dawson', 'Wood Dr. Columbus, OH', '471-221-0031', '$9.50'),
(171, (select ManagerID from Milkshakeshop.Manager where FirstName = 'David'), 'Allan', 'Anderson', 'Riddle Rd. Cincinnati, OH', '512-336-4004', '$9.25'),
(173, (select ManagerID from Milkshakeshop.Manager where FirstName = 'Amber'), 'Ryan', 'Hess', 'Blue Ave. Cincinnati, OH', '365-512-7877', '$9.25'),
(186, (select ManagerID from Milkshakeshop.Manager where FirstName = 'Alex'), 'Emily', 'Bell', 'Grandview Ave., CIncinnati, OH', '621-558-1021', '$9.50')

/*check the table*/
select *from Milkshakeshop.Employee

/*insert data into location table*/
insert into Milkshakeshop.Location(LocationID, ManagerID, EmpID, LocationName, Address)
values
('11B', (select ManagerID from Milkshakeshop.Manager where FirstName = 'Ella'), (Select EmpID from Milkshakeshop.Employee where EmpFirstName='Turner'), 'Colombus 1', 'Pinewood, Colombus, OH'),
('16M', (select ManagerID from Milkshakeshop.Manager where FirstName = 'Konner'), (Select EmpID from Milkshakeshop.Employee where EmpFirstName='Johnny'), 'Chicago 1', 'Middle, Chicago, IL'),
('03R', (select ManagerID from Milkshakeshop.Manager where FirstName = 'Olivia'), (Select EmpID from Milkshakeshop.Employee where EmpFirstName='Abby'), 'Cincinnati 1', 'Spring, CIncinnati, OH'),
('08E', (select ManagerID from Milkshakeshop.Manager where FirstName = 'Alex'), (Select EmpID from Milkshakeshop.Employee where EmpFirstName='Megan'), 'Cincinnati 2', 'Trent, CIncinnati, OH'),
('26H', (select ManagerID from Milkshakeshop.Manager where FirstName = 'Amber'), (Select EmpID from Milkshakeshop.Employee where EmpFirstName='Emilia'), 'Cincinnati 3', 'Newall, Cincinnati, OH'),
('19K', (select ManagerID from Milkshakeshop.Manager where FirstName = 'David'), (Select EmpID from Milkshakeshop.Employee where EmpFirstName='Allan'), 'Cincinnati 4', 'Oak, Cincinnati, OH')

/*check the table*/
select *from Milkshakeshop.Location

/*insert data into product table*/ 
insert into Milkshakeshop.Product(ProductID, ProductName, ProductSize, ProductFlavor, ProductPrice)
values
(2, 'Original Vanilla', 'M', 'Vanilla', '6.50'),
(3, 'Strawberry Cheesecake', 'M', 'Strawberry', '7.50'),
(5, 'Double Chocolate', 'M', 'Chocolate', '7.00'),
(8, 'Salted Caramel', 'S', 'Caramel', '6.00'),
(12, 'Cherry Vanilla', 'S', 'Cherry', '6.50'), 
(13, 'Oreo Cheesecake', 'M', 'Oreo', '7.50'),
(4, 'Strawberry Shortcake', 'S', 'Strawberry', '7.00'),
(10, 'Banana cream', 'M', 'Banana', '7.00'),
(16, 'Mint white Chocolate', 'S', 'Mint', '6.50')

/*check the table*/
select *from Milkshakeshop.Product

/*insert data into customer*/
insert into Milkshakeshop.Customer(CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPhoneNumber)
values
('Julie', 'Moore', 'moore@mail.com', '622-184-3200'),
('Peter', 'Smith', 'smith@mail.com', '032-645-8799'),
('James', 'Antg', 'ants@mail.com', '102-529-3088'),
('Micheal', 'Brown', 'brown@mail.com', '612-335-8701'),
('Mark', 'Chen', 'chen@mail.com', '518-876-3022'),
('Adria', 'Kim', 'kim@mail.com', '950-436-1975')

/*check the table*/
select *from Milkshakeshop.Customer

/*insert data into order table*/
insert into Milkshakeshop.Orders(OrderDate, OrderAmount, LocationID, ProductID, CustomerID)
values
('2019-02-22', '$6.50', (select LocationID from Milkshakeshop.Location where LocationName='Colombus 1'),
(select ProductID from Milkshakeshop.Product where ProductName='Original Vanilla'), (select CustomerID from Milkshakeshop.Customer where CustomerFirstName ='Adria')),
('2019-08-16', '$6.50', (select LocationID from Milkshakeshop.Location where LocationName='Cincinnati 1'),
(select ProductID from Milkshakeshop.Product where ProductName='Cherry Vanilla'), (select CustomerID from Milkshakeshop.Customer where CustomerFirstName ='James')),
('2017-09-21', '$14.00', (select LocationID from Milkshakeshop.Location where LocationName='Cincinnati 3'),
(select ProductID from Milkshakeshop.Product where ProductName='Banana cream'), (select CustomerID from Milkshakeshop.Customer where CustomerFirstName ='Julie')),
('2019-06-25', '$12.50', (select LocationID from Milkshakeshop.Location where LocationName='Chicago 1'),
(select ProductID from Milkshakeshop.Product where ProductName='Salted Caramel'), (select CustomerID from Milkshakeshop.Customer where CustomerFirstName ='Mark')),
('2019-11-19', '$13.50', (select LocationID from Milkshakeshop.Location where LocationName='Cincinnati 2'),
(select ProductID from Milkshakeshop.Product where ProductName='Mint white Chocolate'), (select CustomerID from Milkshakeshop.Customer where CustomerFirstName ='James')),
('2018-09-03', '$7.00', (select LocationID from Milkshakeshop.Location where LocationName='Cincinnati 4'),
(select ProductID from Milkshakeshop.Product where ProductName='Double Chocolate'), (select CustomerID from Milkshakeshop.Customer where CustomerFirstName ='James')),
('2018-04-23', '$7.50', (select LocationID from Milkshakeshop.Location where LocationName='Cincinnati 4'),
(select ProductID from Milkshakeshop.Product where ProductName='Oreo Cheesecake'), (select CustomerID from Milkshakeshop.Customer where CustomerFirstName ='Peter'))

/*check the table*/
select *from Milkshakeshop.Orders

/*view creation script*/
use FinalProject;
go
create view Milkshakeshop.ProductPrice7 as
select ProductName, ProductFlavor, ProductPrice
from Milkshakeshop.Product
where ProductPrice = '7.00'

/*view query*/
select *from Milkshakeshop.ProductPrice7
order by ProductName;

/*create view script*/
use FinalProject;
go
create view Milkshakeshop.CustomerOrder as 
select c.CustomerID, c.CustomerFirstName, c.CustomerLastName, o.orderID, o.ProductID, o.OrderDate, o.OrderAmount
from Milkshakeshop.Customer as c left join Milkshakeshop.Orders as o
on c.CustomerID = o.CustomerID;
go

/*view query*/
select CustomerID, CustomerFirstName, CustomerLastname, OrderDate, OrderAmount
from Milkshakeshop.CustomerOrder
where OrderDate >= '2018-01-01';

/*stored procedures*/
create procedure Milkshakeshop.SelectAllEmployees as 
select *from Milkshakeshop.Employee;
go

exec Milkshakeshop.SelectAllEmployees;

/*another stored procedures*/
create procedure Milkshakeshop.SelectShop @LocationName varchar(100)
as 
select *from Milkshakeshop.Location where LocationName = @LocationName;
go

exec Milkshakeshop.SelectShop @LocationName = 'Cincinnati 1';

/*tSQL unit test*/
EXEC tSQLt.NewTestClass 'Mytest';
GO

CREATE PROCEDURE Mytest.[test ManagerID is returning int value]
AS
BEGIN
    DECLARE @ManagerID INT; 
	SELECT @ManagerID = 1;

    EXEC tSQLt.AssertEquals 1, @ManagerID;

END;
GO

EXEC tSQLt.Run 'Mytest'

/*another unit test*/
EXEC tSQLt.NewTestClass 'secondtest';
GO
CREATE PROCEDURE secondtest.[test locationID is returning varchar value]
AS
BEGIN
    DECLARE @LocationID varchar(7); 
	SELECT @LocationID = '11B';

    EXEC tSQLt.AssertEquals '11B', @LocationID;

END;
GO

EXEC tSQLt.Run 'secondtest'



/*security script to run to create one user login and one user
setting a few permissions to that to perform various functions
over the defined tables*/

/*create login*/
create login Ayumi from windows
create login Ayumi with password
'AyumiMutoh11'

/*create user*/
create user AyumiSecurity from login Ayumi

/*define permissions*/
grant select on Milkshakeshop.Manager to AyumiSecurity
grant select on Milkshakeshop.Employee to AyumiSecurity
grant insert on Milkshakeshop.Customer to AyumiSecurity



