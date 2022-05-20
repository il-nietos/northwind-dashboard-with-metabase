-- copy content from csv files to tables - 11 tables 

DELETE FROM categories;
DELETE FROM customers;
DELETE FROM employee_territories;
DELETE FROM employees;
DELETE FROM order_details;
DELETE FROM orders;
DELETE FROM products;
DELETE FROM regions;
DELETE FROM shippers;
DELETE FROM suppliers;
DELETE FROM territories;


\copy employees FROM '/Users/ilonanietosvaara/Documents/Kurssit/spiced/spiced_projects/scikit-cilantro-student-code/week_05/project_05/northwind_data_clean/data/employees.csv' WITH DELIMITER AS ',' NULL AS 'NULL' CSV HEADER; 
\copy regions FROM '/Users/ilonanietosvaara/Documents/Kurssit/spiced/spiced_projects/scikit-cilantro-student-code/week_05/project_05/northwind_data_clean/data/regions.csv' WITH DELIMITER AS ',' NULL AS 'NULL' CSV HEADER; 
\copy territories FROM '/Users/ilonanietosvaara/Documents/Kurssit/spiced/spiced_projects/scikit-cilantro-student-code/week_05/project_05/northwind_data_clean/data/territories.csv' WITH DELIMITER AS ',' NULL AS 'NULL' CSV HEADER; 
\copy employee_territories FROM '/Users/ilonanietosvaara/Documents/Kurssit/spiced/spiced_projects/scikit-cilantro-student-code/week_05/project_05/northwind_data_clean/data/employee_territories.csv' WITH DELIMITER AS ',' NULL AS 'NULL' CSV HEADER; 
\copy categories FROM '/Users/ilonanietosvaara/Documents/Kurssit/spiced/spiced_projects/scikit-cilantro-student-code/week_05/project_05/northwind_data_clean/data/categories.csv' DELIMITER ',' NULL AS 'NULL' CSV HEADER;
\copy suppliers FROM '/Users/ilonanietosvaara/Documents/Kurssit/spiced/spiced_projects/scikit-cilantro-student-code/week_05/project_05/northwind_data_clean/data/suppliers.csv' WITH DELIMITER AS ',' NULL AS 'NULL' CSV HEADER; 
\copy shippers FROM '/Users/ilonanietosvaara/Documents/Kurssit/spiced/spiced_projects/scikit-cilantro-student-code/week_05/project_05/northwind_data_clean/data/shippers.csv' WITH DELIMITER AS ',' NULL AS 'NULL' CSV HEADER; 
\copy customers FROM '/Users/ilonanietosvaara/Documents/Kurssit/spiced/spiced_projects/scikit-cilantro-student-code/week_05/project_05/northwind_data_clean/data/customers.csv' WITH DELIMITER AS ',' NULL AS 'NULL' CSV HEADER; 
\copy products FROM '/Users/ilonanietosvaara/Documents/Kurssit/spiced/spiced_projects/scikit-cilantro-student-code/week_05/project_05/northwind_data_clean/data/products.csv' WITH DELIMITER AS ',' NULL AS 'NULL' CSV HEADER; 
\copy orders FROM '/Users/ilonanietosvaara/Documents/Kurssit/spiced/spiced_projects/scikit-cilantro-student-code/week_05/project_05/northwind_data_clean/data/orders.csv' WITH DELIMITER AS ',' NULL AS 'NULL' CSV HEADER; 
\copy order_details FROM '/Users/ilonanietosvaara/Documents/Kurssit/spiced/spiced_projects/scikit-cilantro-student-code/week_05/project_05/northwind_data_clean/data/order_details.csv' WITH DELIMITER AS ',' NULL AS 'NULL' CSV HEADER; 


/*
COPY 9
COPY 4
COPY 53
COPY 49
COPY 8
COPY 29
COPY 3
COPY 91
COPY 77
COPY 830
COPY 2155
*/




