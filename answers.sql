Question 1
    
CREATE TABLE ProductDetail_Normalized (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

Insert data into the new table
INSERT INTO ProductDetail_Normalized (OrderID, CustomerName, Product)
SELECT OrderID, CustomerName, TRIM(value)
FROM ProductDetail
CROSS JOIN JSON_TABLE(
    CONCAT('[', REPLACE(Products, ', ', '","'), ']'),
    '$[*]' COLUMNS (value VARCHAR(255) PATH '$')
) AS products_split;

Question 2

Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

Create the OrderDetails table
CREATE TABLE OrderDetails (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

Populate the Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails_1NF;

-- Populate the OrderDetails table
INSERT INTO OrderDetails (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails_1NF;

