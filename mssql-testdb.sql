-- Step 1: Create a test database
CREATE DATABASE TestDB;
GO

-- Use the created database
USE TestDB;
GO

-- Step 2: Create Users Table
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Step 3: Create Products Table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Step 4: Create Orders Table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);
GO

-- Step 5: Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);
GO

CREATE TABLE Music (
    MusicID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Artist NVARCHAR(255) NOT NULL,
    Album NVARCHAR(255),
    Genre NVARCHAR(100),
    ReleaseDate DATE,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO


CREATE TABLE TouristSpots (
    SpotID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Location NVARCHAR(255) NOT NULL,
    Description NVARCHAR(500),
    Category NVARCHAR(100),
    EstablishedDate DATE,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    RegisteredDate DATETIME
);
GO


CREATE TABLE OrdersHistory (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10,2),
    Status NVARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Rating INT,
    ReviewText NVARCHAR(500),
    ReviewDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE Suppliers (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName NVARCHAR(100),
    ContactPerson NVARCHAR(50),
    Phone NVARCHAR(20),
    Address NVARCHAR(200)
);


CREATE TABLE Warehouses (
    WarehouseID INT IDENTITY(1,1) PRIMARY KEY,
    WarehouseName NVARCHAR(100),
    Location NVARCHAR(100),
    Capacity INT
);


CREATE TABLE Shipments (
    ShipmentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    ShipmentDate DATETIME,
    Carrier NVARCHAR(50),
    TrackingNumber NVARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES OrdersHistory(OrderID)
);

-- Step 6: Insert Sample Data into Users Table (1000 users)
INSERT INTO Users (FirstName, LastName, Email)
SELECT TOP (10000)
    'User' + CAST(ABS(CHECKSUM(NEWID())) % 10000 AS NVARCHAR(10)), 
    'Test', 
    'user' + CAST(NEWID() AS NVARCHAR(36)) + '@test.com'
FROM sys.all_objects a
CROSS JOIN sys.all_objects b;

update users
set LastName = 'dataisec'
where LastName = 'Test';


-- Step 7: Insert Sample Data into Products Table (100 products)
INSERT INTO Products (ProductName, Price, Stock)
SELECT TOP (1000)
    'Product ' + CAST(ABS(CHECKSUM(NEWID())) % 10000 AS NVARCHAR(10)),
    CAST(ABS(CHECKSUM(NEWID())) % 100 + (RAND() * 100) AS DECIMAL(10,2)),
    ABS(CHECKSUM(NEWID())) % 500 + 1
FROM sys.all_objects;
CROSS JOIN sys.all_objects b;

-- Step 8: Insert Sample Data into Orders Table (1000 orders)
INSERT INTO Orders (UserID, OrderDate, TotalAmount)
SELECT TOP (1000)
    (SELECT TOP 1 UserID FROM Users ORDER BY NEWID()),
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE()),
    CAST(ABS(CHECKSUM(NEWID())) % 1000 + (RAND() * 1000) AS DECIMAL(10,2))
FROM sys.all_objects;
CROSS JOIN sys.all_objects b;


-- Step 9: Insert Sample Data into OrderDetails Table (2000 records)
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
SELECT TOP (1000)
    (SELECT TOP 1 OrderID FROM Orders ORDER BY NEWID()),
    (SELECT TOP 1 ProductID FROM Products ORDER BY NEWID()),
    ABS(CHECKSUM(NEWID())) % 10 + 1,
    CAST(ABS(CHECKSUM(NEWID())) % 100 + (RAND() * 100) AS DECIMAL(10,2))
FROM sys.all_objects;
CROSS JOIN sys.all_objects b;


-- Step 10: Verify Data Counts
SELECT 'Users' AS TableName, COUNT(*) AS RecordCount FROM Users
UNION ALL
SELECT 'Products', COUNT(*) FROM Products
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'OrderDetails', COUNT(*) FROM OrderDetails;
GO


-- Employees
INSERT INTO Employees (FirstName, LastName, Email)
SELECT TOP (10)
    'staff' + CAST(ABS(CHECKSUM(NEWID())) % 10000 AS NVARCHAR(10)),  
    'Test',  
    'staff' + CAST(ABS(CHECKSUM(NEWID())) % 10000 AS NVARCHAR(10)) + '@gmail.com'
FROM sys.all_objects;
CROSS JOIN sys.all_objects b;

-- Music
INSERT INTO Music (Title, Artist, Album, Genre, ReleaseDate)
SELECT TOP (1000)
    'Song' + CAST(ABS(CHECKSUM(NEWID())) % 10000 AS NVARCHAR(10)),  
    'Artist' + CAST(ABS(CHECKSUM(NEWID())) % 10000 AS NVARCHAR(10)),  
    'Album' + CAST(ABS(CHECKSUM(NEWID())) % 10000 AS NVARCHAR(10)),  
    (SELECT TOP 1 Genre FROM (VALUES ('Pop'), ('Rock'), ('Jazz'), ('Hip-Hop'), ('Classical')) AS GenreList(Genre) ORDER BY NEWID()),  
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 3650, GETDATE())  
FROM sys.all_objects;
CROSS JOIN sys.all_objects b;

-- TouristSpots
INSERT INTO TouristSpots (Name, Location, Description, Category, EstablishedDate)
SELECT TOP (1000)
    '景點' + CAST(ABS(CHECKSUM(NEWID())) % 10000 AS NVARCHAR(10)),  
    '城市' + CAST(ABS(CHECKSUM(NEWID())) % 100 AS NVARCHAR(10)),  
    '這是一個受歡迎的旅遊景點。',
    (SELECT TOP 1 Category FROM (VALUES 
        ('自然景觀'), ('歷史遺跡'), ('宗教建築'), ('建築'), ('文化遺產')
    ) AS Categories(Category) ORDER BY NEWID()),  
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 20000, GETDATE())
FROM sys.all_objects;
CROSS JOIN sys.all_objects b;

-- delete
delete from users;
DBCC CHECKIDENT ('Users', RESEED, 0);
delete from products;
DBCC CHECKIDENT ('Products', RESEED, 0);
delete from orders;
DBCC CHECKIDENT ('orders', RESEED, 0);
delete from orderdetails;
DBCC CHECKIDENT ('orderdetails', RESEED, 0);
delete from TouristSpots;
DBCC CHECKIDENT ('TouristSpots', RESEED, 0);
delete from Music;
DBCC CHECKIDENT ('Music', RESEED, 0);
delete from Employees;
DBCC CHECKIDENT ('Employees', RESEED, 0);

--select sessions
-- 查詢目前連線數
SELECT COUNT(*) FROM sys.dm_exec_connections

-- 查詢 session 詳細資料
SELECT 
    session_id,
    client_net_address AS client_ip,
    local_net_address AS server_ip,
    local_tcp_port AS server_port,
    client_tcp_port
FROM sys.dm_exec_connections;


--kill sessions
DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql = @sql + 'KILL ' + CAST(session_id AS NVARCHAR) + ';' + CHAR(13)
FROM sys.dm_exec_sessions
WHERE login_name LIKE '%DATAISEC-LAB%'
AND login_name <> 'DATAISEC-LAB\Administrator';

PRINT @sql; 
EXEC sp_executesql @sql;
