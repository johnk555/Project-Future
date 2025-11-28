SELECT * FROM HumanResources.Department;

CREATE TABLE dbo.Test(
	ProductID INT,
	ProductName NVARCHAR(MAX)
);

ALTER TABLE dbo.Test
ADD ReleaseDate DATETIME2;

SELECT * FROM dbo.Test;

ALTER TABLE dbo.Test
DROP COLUMN ReleaseDate

DROP TABLE dbo.Test;

INSERT INTO dbo.Test (ProductID, ProductName, ReleaseDate)
VALUES(1, 'T-Shirt', '2020-01-15'),
VALUES(2, 'Trousers', '2021-05-07');


-- Filtering with WHERE
SELECT ProductID, Name, Color, DaysToManufacture
FROM Production.Product;

SELECT ProductID, Name, Color, DaysToManufacture		/* Executed Last */
FROM Production.Product									/* Executed first */
WHERE Color = 'Black';									/* Executed second */

SELECT ProductID, Name, Color, DaysToManufacture		
FROM Production.Product									
WHERE DaysToManufacture <= 3 AND Color = 'Black' AND ProductID > 399;

SELECT ProductID, Name, Color, DaysToManufacture		
FROM Production.Product									
WHERE Color = 'Black' OR Color ='Red';

SELECT ProductID, Name, Color, DaysToManufacture		
FROM Production.Product									
WHERE Color = 'Black' OR Color ='Red' OR DaysToManufacture >= 4;

SELECT ProductID, Name, Color, DaysToManufacture		
FROM Production.Product									
WHERE (Color = 'Black' OR Color ='Red') AND DaysToManufacture >= 4;

SELECT ProductID, Name, Color, DaysToManufacture		
FROM Production.Product									
WHERE (Color = 'Black' AND DaysToManufacture >= 3) OR (Color = 'Red' AND DaysToManufacture <= 2);

SELECT ProductID, Name, Color, DaysToManufacture		
FROM Production.Product		
WHERE NOT Color = 'Black';

SELECT ProductID, Name, Color, DaysToManufacture		
FROM Production.Product		
WHERE NOT Color = 'Black' AND DaysToManufacture = 1;

SELECT ProductID, Name, Color, DaysToManufacture		
FROM Production.Product		
WHERE NOT Color = 'Black' AND NOT DaysToManufacture = 1;

SELECT ProductID, Name, Color, DaysToManufacture		
FROM Production.Product		
WHERE 
(NOT Color = 'Black' AND NOT DaysToManufacture = 1)
AND
(NOT Color = 'Red' AND NOT DaysToManufacture = 4);

SELECT ProductID, Name, Color		
FROM Production.Product	
WHERE Color = 'Black';

SELECT ProductID, Name, Color		
FROM Production.Product	
WHERE Color LIKE ('%Black%')  --Products whose color includes Black, regardless of values before of after the word Black
ORDER BY Name DESC;

SELECT ProductID, Name, Color		
FROM Production.Product	
WHERE Color LIKE ('%Black%')  --Products whose color includes Black, regardless of values before of after the word Black
ORDER BY Name DESC;

SELECT * FROM dbo.Test;
DELETE  FROM dbo.Test;

DELETE FROM dbo.Test
WHERE ProductID = 1; -- Only delete products that have id 1

TRUNCATE TABLE dbo.Test; -- Mass delete all rows in a table

SELECT * FROM dbo.test;

UPDATE dbo.Test
SET ProductName = 'Shirt'; -- DO NOT DO THIS - This will change all rows in the table

UPDATE dbo.Test
SET ProductName = 'Shirt'
WHERE ProductID = 1;

UPDATE dbo.Test
SET ProductName = 'T-Shirt', ReleaseDate = SYSDATETIME()
WHERE ProductID = 1;

UPDATE dbo.Test
SET ProductName = 'Shorts', ReleaseDate = '2025-11-28 20:00:30'  -- YYYY-MM-DD HH:MM:SS
WHERE ProductID = 2;

UPDATE Production.Product
SET Color = 'Ruby'
WHERE Color = 'Red';

UPDATE Production.Product
SET Color = 'Red'
WHERE Color = 'Ruby';

SELECT * FROM Production.Product
ORDER BY Color;

SELECT Color
FROM Production.Product
ORDER BY Color;

SELECT DISTINCT Color			-- Distinct removes duplicates from the final result
FROM Production.Product
ORDER BY Color;

SELECT Color, Style			-- Unique combinations of color and style
FROM Production.Product
ORDER BY Color, Style;

SELECT DISTINCT TOP 3 COLOR
FROM Production.Product
ORDER BY Color DESC;

SELECT DISTINCT TOP 3 ProductID, Name
FROM Production.Product
ORDER BY ProductID;

SELECT DISTINCT TOP 5 ProductID, Name
FROM Production.Product
ORDER BY ProductID DESC;

SELECT ProductID, Name, Color
FROM Production.Product
ORDER BY ProductID
OFFSET 2 ROWS				-- Ignore first 2 rows
FETCH FIRST 5 ROWS ONLY;	-- Then retrieve only 5 rows

SELECT TOP 5 WITH TIES Color
FROM Production.Product
ORDER BY Color DESC; -- Take the first 5 rows by color but then also include all ties with the last row

SELECT TOP 10 WITH TIES Name, Color, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;

SELECT TOP(10) PERCENT Name, Color, ListPrice
FROM Production.Product
ORDER BY ProductID;

SELECT ProductID, Name, Color
FROM Production.Product
ORDER BY ProductID
OFFSET 10 ROWS -- Ignore first 10 product ids
FETCH FIRST 42 ROWS ONLY;	-- Take the next 42

-- Joins

SELECT Production.Product.ProductID, Production.Product.Name, Production.Product.Color, Production.Product.ProductSubcategoryID
FROM Production.Product
INNER JOIN Production.ProductSubcategory  -- INNER = Only products that have a subcategory and subcategories that have a product
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID;

SELECT * FROM Production.Product;
SELECT * FROM Production.ProductSubcategory;

SELECT Production.Product.ProductID, Production.Product.Name, Production.Product.Color, Production.Product.ProductSubcategoryID, Production.ProductSubcategory.Name
FROM Production.Product
RIGHT JOIN Production.ProductSubcategory  -- RIGHT = All subcategories even if they do not have any products
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID;

SELECT Production.Product.ProductID, Production.Product.Name, Production.Product.Color, Production.Product.ProductSubcategoryID, Production.ProductSubcategory.Name
FROM Production.Product
FULL JOIN Production.ProductSubcategory  -- Full = All rows from both tables whether they can be matched or not
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID;

SELECT Production.Product.Name AS Name, Production.ProductSubcategory.Name AS SubcategoryName, Production.ProductCategory.Name AS CategoryName
FROM Production.Product
LEFT JOIN Production.ProductSubcategory
ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
LEFT JOIN Production.ProductCategory
ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID;

SELECT *
FROM Production.Product AS p
LEFT JOIN Production.ProductSubcategory AS s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
LEFT JOIN Production.ProductCategory AS c
ON s.ProductCategoryID = c.ProductCategoryID
LEFT JOIN Production.ProductModel m
ON p.ProductModelID = m.ProductModelID;
