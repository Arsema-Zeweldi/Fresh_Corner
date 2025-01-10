CREATE DATABASE FreshCorner;
USE FreshCorner;

CREATE TABLE Patron (
    PatronID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50),
    Email NVARCHAR(50) NOT NULL,
    PhoneNumber NVARCHAR(20) NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    legacy_points INT DEFAULT 0,
    deliveryAddress NVARCHAR(100)
);
drop table Category
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL UNIQUE
);



CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(50) NOT NULL UNIQUE,
    CategoryID INT,
	price DECIMAL(10,2),
	Image VARBINARY(MAX),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) ON DELETE CASCADE
);

CREATE TABLE CustomerOrder (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    PatronID INT,
    Quantity INT,
    Price DECIMAL(10,2),
	PaymentStatus NVARCHAR(10) DEFAULT 'pending',
	FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	FOREIGN KEY (PatronID) REFERENCES Patron(PatronID)
);

CREATE TABLE SpecialOffers (
	OfferID INT PRIMARY KEY IDENTITY(1,1),
	ProductID INT,
	Price DECIMAL(10, 2),
	TimeLimit DATETIME,
	QuantityRequired INT,
	FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
