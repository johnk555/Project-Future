CREATE DATABASE MyNewDatabase;
GO
USE MyNewDatabase;

CREATE TABLE Products(
	ProductName NVARCHAR(MAX),  -- Text (string)   --VARCHAR, NCHAR(10), CHAR(10)
	Price FLOAT,
	ReleaseYear INT,
	Discontinued BIT,			-- True/False
	ReleaseDate DATETIME2
);

DROP TABLE Products;

ALTER TABLE Products
ADD Color NVARCHAR(MAX);		-- Add a column

ALTER TABLE Products
ADD Money DECIMAL(7,2);	-- Total number of digits, total number of decimal degits (eg. 99999.99)

ALTER TABLE Products 
DROP COLUMN Color;				-- Remove a column

INSERT INTO Products (ProductName, Price, Discontinued)
VALUES ('T-Shirt', 10.99, 0)

INSERT INTO Products (ProductName, Color, Price, Discontinued)
VALUES ('Jacket', 'Black', 49.99, 0);

INSERT INTO Products -- Automatically assumes all columns in the order they appear in the table
VALUES ('Trousers', 46.99, 10, 0, '2025-01-15', 'Red') -- Dates always as text in YYYY-MM-DD

INSERT INTO Products (ProductName, Color, Price, Discontinued, ReleaseDate)
VALUES ('Jacket', 'Black', 49.99, 0, '2025-01-15');

INSERT INTO Products (ProductName, Color, Price, Discontinued)
VALUES
('Jacket', 'Black', 49.99, 0),
('Laptop', 'Silver', 1999.90, 0),
('Desktop', 'Black', 999.80, 1);

SELECT * FROM Products;								-- Select all (*) columns

SELECT ProductName, Price, Color FROM Products		-- Select specific columns
ORDER BY ProductName, Price;

SELECT ProductName, Price, Color FROM Products		-- Select specific columns
ORDER BY ProductName DESC;

SELECT ProductName,Price, Color FROM Products
WHERE ProductName = 'Laptop'
ORDER BY ProductName, Price DESC

SELECT ProductName,Price, Color FROM Products
WHERE Price >= 49.99; 

SELECT ProductName, Color FROM Products
WHERE Price > 80 AND ProductName != 'Laptop';
