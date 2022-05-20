DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS regions CASCADE;
DROP TABLE IF EXISTS territories CASCADE;
DROP TABLE IF EXISTS employee_territories CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS suppliers CASCADE;
DROP TABLE IF EXISTS shippers CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS order_details CASCADE;

-- employees
CREATE TABLE IF NOT EXISTS employees (
    employeeID INT PRIMARY KEY,
    lastName TEXT,
    firstName TEXT,
    title TEXT,
    titleOfCourtesy VARCHAR(10),
    birthDate DATE,
    hireDate DATE,
    address TEXT,
    city TEXT,
    region VARCHAR(10),
    postalCode TEXT,
    country VARCHAR(10),
    homePhone TEXT,
    extension INT,
    photo BYTEA,
    notes TEXT,
    reportsTo INT,
    photoPath TEXT,

        FOREIGN KEY (country) REFERENCES countries(countries_name) ON DELETE CASCADE

    );

-- regions
CREATE TABLE IF NOT EXISTS regions (
    regionID SERIAL PRIMARY KEY,
    regionDescription TEXT UNIQUE
);


-- territories
CREATE TABLE IF NOT EXISTS territories (
    territoryID INT PRIMARY KEY,
    territoryDescription TEXT,
    regionID INT,

        FOREIGN KEY (regionID) REFERENCES regions(regionID) ON DELETE CASCADE

);

-- employee territories link
CREATE TABLE IF NOT EXISTS employee_territories (
    employeeID INT,
    territoryID INT,

    FOREIGN KEY (employeeID) REFERENCES employees(employeeID) ON DELETE CASCADE,
    FOREIGN KEY (territoryID) REFERENCES territories(territoryID) ON DELETE CASCADE

);

-- categories
CREATE TABLE IF NOT EXISTS categories (
    categoryID SERIAL PRIMARY KEY,
    categoryName TEXT,
    description TEXT,
    picture TEXT
);

-- suppliers
CREATE TABLE IF NOT EXISTS suppliers (
    supplierID SERIAL PRIMARY KEY,
    companyName TEXT,
    contactName TEXT,
    contactTitle TEXT,
    address TEXT,
    city TEXT,
    region TEXT,
    postalCode TEXT,
    country TEXT,
    phone TEXT,
    fax TEXT,
    homePage TEXT,

    FOREIGN KEY (country) REFERENCES countries(countries_name) ON DELETE CASCADE
);

-- shippers

CREATE TABLE IF NOT EXISTS shippers (
    shipperID SERIAL PRIMARY KEY,
    companyName TEXT,
    phone TEXT
);

-- customers
CREATE TABLE IF NOT EXISTS customers (
    customerID TEXT PRIMARY KEY,
    companyName TEXT,
    contactName TEXT,
    contactTitle TEXT,
    address TEXT,
    city TEXT,
    region TEXT,
    postalCode TEXT,
    country TEXT,
    phone TEXT,
    fax TEXT,

    FOREIGN KEY (country) REFERENCES countries(countries_name) ON DELETE CASCADE
);


-- products
CREATE TABLE IF NOT EXISTS products (
    productID SERIAL PRIMARY KEY,
    productName TEXT,
    supplierID INT,
    categoryID INT,
    quantityPerUnit TEXT,
    unitPrice NUMERIC,
    unitsInStock INT,
    unitsInOrder INT,
    reorderLevel INT,
    discontinued BOOLEAN
);

-- orders
CREATE TABLE IF NOT EXISTS orders (
    orderID INT PRIMARY KEY,
    customerID TEXT,
    employeeID INT,
    orderDate TIMESTAMP,
    requiredDate TIMESTAMP,
    shippedDate TIMESTAMP,
    shipVia INT,
    freight NUMERIC,
    shipName TEXT,
    shipAddress TEXT,
    shipCity TEXT,
    shipRegion TEXT,
    shipPostalCode TEXT,
    shipCountry TEXT,

    FOREIGN KEY (employeeID) REFERENCES employees(employeeID) ON DELETE CASCADE,
    FOREIGN KEY (customerID) REFERENCES customers(customerID) ON DELETE CASCADE,
    FOREIGN KEY (shipCountry) REFERENCES countries(countries_name) ON DELETE CASCADE
);

-- order details
CREATE TABLE IF NOT EXISTS order_details (
    orderID INT,
    productID INT,
    unitPrice NUMERIC,
    quantity INT,
    discount NUMERIC,

    FOREIGN KEY (orderID) REFERENCES orders(orderID) ON DELETE CASCADE,
    FOREIGN KEY (productID) REFERENCES products(productID) ON DELETE CASCADE
);





