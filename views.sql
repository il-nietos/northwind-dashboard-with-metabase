--SQL_views


DROP VIEW IF EXISTS product_quantities;
CREATE VIEW product_quantities AS (
SELECT p.ProductID, p.productName, SUM(quantity) AS Total_Quantity_ordered
    FROM order_details o
    INNER JOIN products p
    ON p.productID = o.productID
    
    GROUP BY p.ProductID
    ORDER BY SUM(Quantity) DESC
);

-- products above average price
DROP VIEW IF EXISTS products_above_avprice;
CREATE VIEW products_above_avprice AS (
    SELECT DISTINCT ProductName, UnitPrice, unitsInOrder, unitsInStock
    FROM Products   
    WHERE UnitPrice > (SELECT avg(UnitPrice) FROM Products)
    ORDER BY UnitPrice);

/*
SELECT DISTINCT ProductName, UnitPrice
FROM Products   
WHERE UnitPrice > (SELECT avg(UnitPrice) FROM Products)
ORDER BY UnitPrice;
*/

-- Orders stock 
DROP VIEW IF EXISTS orders_stock;
CREATE VIEW orders_stock AS (
SELECT productName, unitsinorder, unitsInStock, discontinued
    FROM products
    ORDER BY unitsinorder DESC
);


-- Order id, quantity, company, customerid 

DROP VIEW IF EXISTS orders_customers;
CREATE VIEW orders_customers AS (
SELECT od.orderID, od.quantity, c.companyName, c.customerID
    FROM orders o
    INNER JOIN customers c
    ON c.customerID = o.customerID
    INNER JOIN order_details od 
    ON o.orderID = od.orderID
    --GROUP BY c.companyName
);

DROP VIEW IF EXISTS orders_customers_plus;
CREATE VIEW orders_customers_plus AS (
SELECT od.orderID, od.quantity, c.companyName, c.customerID, o.requiredDate, o.shippedDate, o.shipcountry, o.shipcity
    FROM orders o
    INNER JOIN customers c
    ON c.customerID = o.customerID
    INNER JOIN order_details od 
    ON o.orderID = od.orderID
    --GROUP BY c.companyName
);

-- orders customers and employees 
DROP VIEW IF EXISTS employees_customers_orders;
CREATE VIEW employees_customers_orders AS (
SELECT o.orderID, o.requiredDate, o.shippedDate, o.orderDate, o.shipcountry, c.companyName, c.customerID, c.country, c.city, e.firstname, e.lastname, e.employeeID, e.hireDate
    FROM orders o
    INNER JOIN customers c
    ON c.customerID = o.customerID
    INNER JOIN employees e 
    ON e.employeeID = o.employeeID
    --GROUP BY c.companyName
);


-- REVENUE by country and year
DROP VIEW IF EXISTS revenue_year_country;
CREATE VIEW revenue_year_country AS (
SELECT SUM(od.unitPrice) AS Revenue, shipcountry, EXTRACT(YEAR FROM o.orderdate) AS orderyear 
FROM Order_Details od
    INNER JOIN Orders o ON o.OrderID = od.OrderID
    GROUP BY EXTRACT(YEAR FROM o.orderdate), shipcountry
);

-- REVENUE by country
DROP VIEW IF EXISTS revenue_country;
CREATE VIEW revenue_country AS (
SELECT SUM(od.unitPrice) AS Revenue, shipcountry
FROM Order_Details od
    INNER JOIN Orders o ON o.OrderID = od.OrderID

    GROUP BY shipcountry
);

DROP VIEW IF EXISTS revenue_country_iso;
CREATE VIEW revenue_country_iso AS (
SELECT SUM(od.unitPrice) AS Revenue, o.shipcountry, c.countries_iso_code, c.countries_isd_code
FROM Order_Details od
    INNER JOIN Orders o ON o.OrderID = od.OrderID
    INNER JOIN countries c ON c.countries_name = o.shipcountry
    GROUP BY shipcountry, c.countries_iso_code, c.countries_isd_code
);

-- REVENUE by country and year and month
DROP VIEW IF EXISTS revenue_month_country_iso;
CREATE VIEW revenue_month_country_iso AS (
SELECT SUM(od.unitPrice) AS revenue, shipcountry, c.countries_iso_code, c.countries_isd_code, EXTRACT(MONTH FROM o.orderdate) AS ordermonth, EXTRACT(YEAR FROM o.orderdate) AS orderyear
FROM Order_Details od
    INNER JOIN Orders o ON o.OrderID = od.OrderID
    INNER JOIN countries c ON c.countries_name = o.shipcountry
    GROUP BY ordermonth, orderyear, shipcountry, c.countries_iso_code, c.countries_isd_code
);


-- REVENUE by country and year - NEW
SELECT SUM(od.unitPrice) AS revenue, shipcountry, c.countries_iso_code, c.countries_isd_code, EXTRACT(YEAR FROM o.orderdate) AS orderyear
FROM Order_Details od
    INNER JOIN Orders o ON o.OrderID = od.OrderID
    INNER JOIN countries c ON c.countries_name = o.shipcountry
    GROUP BY orderyear, shipcountry, c.countries_iso_code, c.countries_isd_code

-- min and max years
/*
SELECT max(EXTRACT(YEAR FROM orderdate)) FROM orders 
SELECT min(EXTRACT(YEAR FROM orderdate)) FROM orders
*/

-- REVENUE by year
DROP VIEW IF EXISTS revenue_pyear;
CREATE VIEW revenue_pyear AS (
    SELECT SUM(od.unitPrice) AS Revenue 
    FROM Order_Details od
    INNER JOIN Orders o 
    ON o.OrderID = od.OrderID
    GROUP BY EXTRACT(YEAR FROM o.orderdate)
);

--- VIEW of price and total quantity
DROP VIEW IF EXISTS categories_orders;
CREATE VIEW categories_orders AS (
SELECT c.categoryName, SUM(o.quantity)
    FROM products p
    INNER JOIN order_details o
    ON o.productID = p.productID
    INNER JOIN categories c

    ON c.categoryID = p.categoryID
    
    GROUP BY c.categoryName
    );


-- Orders by category 
DROP VIEW IF EXISTS categories_orders;
CREATE VIEW categories_orders AS (
SELECT c.categoryName, SUM(o.quantity) as quant
    FROM products p
    INNER JOIN order_details o
    ON o.productID = p.productID
    INNER JOIN categories c

    ON c.categoryID = p.categoryID
    
    GROUP BY c.categoryName
    ORDER BY quant
    );




-- REVENUE by category - FIXXXX!!! revenue: (unitprice * the discount)  * quantity 
DROP VIEW IF EXISTS revenue_category;
CREATE VIEW revenue_category AS (
    SELECT c.categoryName, SUM(od.unitPrice ) AS Revenue 
    FROM products p
    INNER JOIN order_details od
    ON od.productID = p.productID
    INNER JOIN categories c
    ON c.categoryID = p.categoryID
    GROUP BY c.categoryName
    ORDER BY Revenue
);