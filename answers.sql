Question 1 Achieving 1NF (First Normal Form) 🛠️
CREATE TABLE ProductDetail_Normalized (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Insert data into the new table
INSERT INTO ProductDetail_Normalized (OrderID, CustomerName, Product)
SELECT OrderID, CustomerName, TRIM(value)
FROM ProductDetail
CROSS JOIN JSON_TABLE(
    CONCAT('[', REPLACE(Products, ', ', '","'), ']'),
    '$[*]' COLUMNS (value VARCHAR(255) PATH '$')
) AS products_split;
