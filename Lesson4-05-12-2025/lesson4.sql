SELECT * FROM FactInternetSales;
SELECT * FROM DimProduct;

SELECT ProductKey, EnglishProductName, ListPrice, Color -- See products ordered by colors
FROM DimProduct
ORDER BY Color;

SELECT DISTINCT Color -- See colors
FROM DimProduct
ORDER BY Color;

SELECT Color, Size, ProductLine, COUNT(ProductKey) CountOfProducts, AVG(ListPrice) AveragePrice, SUM(ListPrice) TotalPrice, 
	MIN(ListPrice) MinPrice, MAX(ListPrice) MaxPrice, STDEV(ListPrice) PriveDev
FROM DimProduct
GROUP BY Color, Size, ProductLine -- One group (row) per unique combination of color & size
ORDER BY Color, Size;

SELECT ProductLine, COUNT(Color) CountOfColors, COUNT(ProductKey) CountOfProductKeys -- Will only be different in some product has NULL Color
FROM DimProduct
GROUP BY ProductLine;

SELECT ProductKey, Color, ProductLine
FROM DimProduct
ORDER BY ProductLine;


SELECT ProductLine, COUNT (DISTINCT Color) CountOfColors, COUNT(ProductKey) CountOfProductKeys -- Count of different colors in each product line
FROM DimProduct
GROUP BY ProductLine;

-- Per product category get the number of different colors, count of products and the average price of products
SELECT EnglishProductCategoryName, COUNT (DISTINCT Color) AS CountOfColors, COUNT(ProductKey) CountOfProducts, AVG(ListPrice) AveragePrice
FROM DimProduct p
INNER JOIN DImProductSubcategory s
	ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
INNER JOIN DimProductCategory c
	ON s.ProductCategoryKey = c.ProductCategoryKey
GROUP BY c.ProductCategoryKey, EnglishProductCategoryName;

-- The above query groups on
SELECT *
FROM DimProduct p
INNER JOIN DImProductSubcategory s
	ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
INNER JOIN DimProductCategory c
	ON s.ProductCategoryKey = c.ProductCategoryKey
ORDER BY c.ProductCategoryKey, EnglishProductCategoryName;

-- Get average order details per customer
SELECT c.FirstName, c.LastName, AVG(s.OrderQuantity) AvgQuantity, SUM(SalesAmount) TotalAmount
FROM FactInternetSales s
INNER JOIN DimCustomer c
	ON s.CustomerKey = c.CustomerKey
GROUP BY c.FirstName, c.LastName -- WRONG - this will merge any customers with the same combination of First and Last Name

SELECT c.FirstName, c.LastName, AVG(s.OrderQuantity) AvgQuantity, SUM(SalesAmount) TotalAmount
FROM FactInternetSales s
INNER JOIN DimCustomer c
	ON s.CustomerKey = c.CustomerKey
GROUP BY c.CustomerKey, c.FirstName, c.LastName -- CORRECT - gurantees that each row will be a unique customer

SELECT *
FROM FactInternetSales s
INNER JOIN DimCustomer c
	ON s.CustomerKey = c.CustomerKey

-- Find the count of cutomsers per country
SELECT EnglishCountryRegionName, COUNT(CustomerKey) AS CountOfCustomers, AVG(YearlyIncome) AS AverageIncome, 
	AVG(TotalChildren) AS AverageChildren, COUNT(DISTINCT City) AS CitiesInCountry 
FROM DimCustomer c
INNER JOIN DimGeography g
 ON c.GeographyKey = g.GeographyKey
GROUP BY EnglishCountryRegionName

SELECT *
FROM DimCustomer c
INNER JOIN DimGeography g
 ON c.GeographyKey = g.GeographyKey

 -- Find the count of cutomsers per country and education level
SELECT EnglishCountryRegionName, EnglishEducation, COUNT(CustomerKey) AS CountOfCustomers, AVG(YearlyIncome) AS AverageIncome, 
	AVG(TotalChildren) AS AverageChildren, COUNT(DISTINCT City) AS DifferentCitiesCutomersStayIn 
FROM DimCustomer c
INNER JOIN DimGeography g
 ON c.GeographyKey = g.GeographyKey
GROUP BY EnglishCountryRegionName, EnglishEducation
ORDER BY EnglishCountryRegionName, EnglishEducation;

SELECT EnglishProductCategoryName, SUM(s.OrderQuantity) TotalQuantity, SUM(s.SalesAmount) TotalAmount
FROM FactInternetSales s
INNER JOIN DimProduct p
	ON s.ProductKey = p.ProductKey
INNER JOIN DimProductSubcategory ps
	ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
INNER JOIN DimProductCategory c
	ON ps.ProductCategoryKey = c.ProductCategoryKey
GROUP BY c.ProductCategoryKey, EnglishProductCategoryName;

SELECT Color, SUM(s.OrderQuantity) TotalQuantity, SUM(s.SalesAmount) TotalAmount
FROM FactInternetSales s
INNER JOIN DimProduct p
	ON s.ProductKey = p.ProductKey
GROUP BY p.Color;

SELECT Color, SUM(s.OrderQuantity) TotalQuantity, SUM(s.SalesAmount) TotalAmount
FROM FactInternetSales s
INNER JOIN DimProduct p
	ON s.ProductKey = p.ProductKey
GROUP BY p.Color;

SELECT Color, SUM(s.OrderQuantity) TotalQuantity, SUM(s.SalesAmount) TotalAmount
FROM FactInternetSales s
INNER JOIN DimProduct p
	ON s.ProductKey = p.ProductKey
WHERE p.Color = 'Black'
GROUP BY p.Color;

-- First remove any product that does not have color product black or red, THEN group by color
SELECT Color, SUM(s.OrderQuantity) TotalQuantity, SUM(s.SalesAmount) TotalAmount 
FROM FactInternetSales s
INNER JOIN DimProduct p
	ON s.ProductKey = p.ProductKey
WHERE p.Color = 'Black' OR p.Color = 'Red'
GROUP BY p.Color;

SELECT Color, SUM(s.OrderQuantity) TotalQuantity, SUM(s.SalesAmount) TotalAmount 
FROM FactInternetSales s
INNER JOIN DimProduct p
	ON s.ProductKey = p.ProductKey
GROUP BY p.Color;

-- Group by color ONLY Products that have Size S
SELECT Color, SUM(s.OrderQuantity) TotalQuantity, SUM(s.SalesAmount) TotalAmount 
FROM FactInternetSales s
INNER JOIN DimProduct p
	ON s.ProductKey = p.ProductKey
WHERE p.Size = 'S'
GROUP BY p.Color;


-- Find the count of customers in each country
SELECT EnglishCountryRegionName, COUNT(c.CustomerKey) AS CountOfCustomers
FROM DimCustomer c
INNER JOIN DimGeography g
	ON c.GeographyKey = g.GeographyKey
GROUP BY g.EnglishCountryRegionName;

-- Find the count of bachelors customers in each country
SELECT EnglishCountryRegionName, COUNT(c.CustomerKey) AS CountOfBachelors
FROM DimCustomer c
INNER JOIN DimGeography g
	ON c.GeographyKey = g.GeographyKey
WHERE c.EnglishEducation = 'Bachelors'
GROUP BY g.EnglishCountryRegionName;

-- Count of products per category
SELECT EnglishProductCategoryName, COUNT(ProductKey) CountOfProducts
FROM DimProduct p
INNER JOIN DimProductSubcategory ps
	ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
INNER JOIN DimProductCategory c
	ON ps.ProductCategoryKey = c.ProductCategoryKey
GROUP BY c.ProductCategoryKey, EnglishProductCategoryName;

-- Count of black products per category
SELECT EnglishProductCategoryName, COUNT(ProductKey) CountOfBlackProducts
FROM DimProduct p
INNER JOIN DimProductSubcategory ps
	ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
INNER JOIN DimProductCategory c
	ON ps.ProductCategoryKey = c.ProductCategoryKey
WHERE p.Color = 'Black'
GROUP BY c.ProductCategoryKey, EnglishProductCategoryName;

-- Count of black products per category
SELECT EnglishProductCategoryName, COUNT(ProductKey) CountOfXLBlackProducts
FROM DimProduct p
INNER JOIN DimProductSubcategory ps
	ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
INNER JOIN DimProductCategory c
	ON ps.ProductCategoryKey = c.ProductCategoryKey
WHERE p.Color = 'Black' AND p.Size = 'L'
GROUP BY c.ProductCategoryKey, EnglishProductCategoryName;

-- Count of products per category, keep only categories with 50 or more products
SELECT EnglishProductCategoryName, COUNT(ProductKey) CountOfProducts
FROM DimProduct p
INNER JOIN DimProductSubcategory ps
	ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
INNER JOIN DimProductCategory c
	ON ps.ProductCategoryKey = c.ProductCategoryKey
WHERE p.Color = 'Black'
GROUP BY c.ProductCategoryKey, EnglishProductCategoryName
HAVING COUNT(ProductKey) >= 20;

-- Display cotunries with 2000 or more customers
SELECT EnglishCountryRegionName, COUNT(c.CustomerKey) AS CountOfCustomers
FROM DimCustomer c
INNER JOIN DimGeography g
	ON c.GeographyKey = g.GeographyKey
GROUP BY g.EnglishCountryRegionName
HAVING COUNT(c.CustomerKey) >= 2000;

-- Count of products per subcategory (along with the name of the category in which the subcategory belongs in)
SELECT EnglishProductSubcategoryName, EnglishProductCategoryName, COUNT(ProductKey) CountOfProducts
FROM DimProduct p
INNER JOIN DimProductSubcategory ps
	ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
INNER JOIN DimProductCategory c
	ON ps.ProductCategoryKey = c.ProductCategoryKey
GROUP BY ps.ProductCategoryKey, ps.EnglishProductSubcategoryName, c.EnglishProductCategoryName
HAVING COUNT(ProductKey) >= 10
ORDER BY  c.EnglishProductCategoryName, ps.EnglishProductSubcategoryName;

-- Same as above but only black products
SELECT EnglishProductSubcategoryName, EnglishProductCategoryName, COUNT(ProductKey) CountOfProducts
FROM DimProduct p
INNER JOIN DimProductSubcategory ps
	ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
INNER JOIN DimProductCategory c
	ON ps.ProductCategoryKey = c.ProductCategoryKey
WHERE p.Color = 'Black'
GROUP BY ps.ProductCategoryKey, ps.EnglishProductSubcategoryName, c.EnglishProductCategoryName
HAVING COUNT(ProductKey) >= 10
ORDER BY  c.EnglishProductCategoryName, ps.EnglishProductSubcategoryName;

/*
1. From
2. Join
3. Where
4. Group BY
5. Having
6. Select
7. Order by
*/

SELECT ProductKey, EnglishProductName, ListPrice
FROM DimProduct
WHERE ProductKey = 398; --44.54

BEGIN TRANSACTION;

	UPDATE DimProduct
	SET ListPrice = 100
	WHERE ProductKey = 398;

	UPDATE DimProduct
	SET ListPrice = 100
	WHERE ProductKey = 399;

ROLLBACK;
COMMIT;
GO

CREATE PROCEDURE GetProducts
AS
BEGIN
	SELECT ProductKey, EnglishProductName, Color
	FROM DimProduct;
END;

EXEC GetProducts;
GO

CREATE PROCEDURE GetProductsByColor
 @ColorName NVARCHAR(50)
AS
BEGIN
	SELECT ProductKey, EnglishProductName, Color
	FROM DimProduct
	WHERE Color = @ColorName;
END;

EXEC GetProductsByColor @ColorName = 'Red';
GO

CREATE PROCEDURE GetProductsByColor2
 @ColorName2 NVARCHAR(50)
AS
BEGIN
	EXEC GetProductsByColor @ColorName = @ColorName2
END;

EXEC GetProductsByColor2 @ColorName2 = 'Black';
GO

CREATE PROCEDURE GetProductsByColorAndPrice
 @ColorName NVARCHAR(50),
 @PriceMin FLOAT,
 @PriceMax FLOAT
AS
BEGIN
	SELECT ProductKey, EnglishProductName, Color, ListPrice
	FROM DimProduct
	WHERE Color = @ColorName AND (ListPrice>=@PriceMin AND ListPrice<=@PriceMax)
END;

EXEC GetProductsByColorAndPrice @ColorName = 'Black', @PriceMin = 100, @PriceMax = 300;
GO

CREATE VIEW CountOfProductsByCategory
AS
	SELECT EnglishProductCategoryName, COUNT(ProductKey) CountOfProducts
	FROM DimProduct p
	INNER JOIN DimProductSubcategory ps
		ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
	INNER JOIN DimProductCategory c
		ON ps.ProductCategoryKey = c.ProductCategoryKey
	WHERE p.Color = 'Black'
	GROUP BY c.ProductCategoryKey, EnglishProductCategoryName;
GO

SELECT CountOfProducts FROM CountOfProductsByCategory;

CREATE INDEX indexColor ON DimProduct (Color);

SELECT Size, Color
FROM DimProduct
WHERE Color = 'Black';

SELECT Size, Color
FROM DimProduct
WHERE Color = 'Black' AND Size = 'M';

CREATE TABLE NewProducts
(
	ProductName NVARCHAR(50),
	Color NVARCHAR(50),
	Price FLOAT,
	PRIMARY KEY (ProductName, Color)
);

ALTER TABLE NewProducts
ADD CONSTRAINT PK_NewProducts PRIMARY KEY (ProductName, Color);
