/*USE FreshCorner;*/

CREATE PROCEDURE RetrieveCategory
	@CategoryName NVARCHAR(50)
AS
BEGIN
	DECLARE @CategoryID INT;

	SELECT @CategoryID = CategoryID
	FROM Category
	WHERE CategoryName = @CategoryName;

	SELECT * 
	FROM Product
	WHERE CategoryID = @CategoryID;
END;

CREATE PROCEDURE ValidateLogin
	@Email NVARCHAR(50),
	@Password NVARCHAR(50),
	@Success INT OUTPUT
AS
BEGIN
	DECLARE @HashedPassword VARBINARY(64);
	SET @Success = 0;

	SET @HashedPassword = HASHBYTES('SHA2_256', @Password);

	SELECT @Success = COUNT(*)
    FROM Patron
    WHERE Email = @Email AND PasswordHash = @HashedPassword;

END;

CREATE PROCEDURE AddPatron
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(50),
    @PhoneNumber NVARCHAR(20),
    @Password NVARCHAR(50),
    @deliveryAddress NVARCHAR(100),
	@PatronID INT OUTPUT
AS
BEGIN
	DECLARE @HashedPassword VARBINARY(64);
	SET @HashedPassword = HASHBYTES('SHA2_256', @Password);

	DECLARE @PatronID INT;

    SELECT @PatronID = PatronID 
    FROM Patron 
    WHERE Email = @Email;

    IF @PatronID IS NULL
    BEGIN
		INSERT INTO Patron (FirstName, LastName, Email, PhoneNumber, Password, deliveryAddress)
		VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @HashedPassword, @deliveryAddress);
		SELECT @PatronID = SCOPE_IDENTITY();
    END

    SELECT @PatronID;
END;


CREATE PROCEDURE MakeOrder
	@ProductName NVARCHAR(50),
	@PatronID INT,
	@Quantity INT,
	@PaymentStatus NVARCHAR(10),
	@Success INT OUTPUT
AS
BEGIN
	SET @Success = 0;

	DECLARE @ProductID INT;

	SELECT @ProductID = ProductID
	FROM Product
	WHERE product_name = @ProductName;

	IF @ProductID > 0
	BEGIN

		DECLARE @TotalPrice INT;
		DECLARE @IndividualPrice INT;
		SELECT @IndividualPrice = Price
		FROM Product
		WHERE ProductID = @ProductID;

		SET @TotalPrice = @IndividualPrice * @Quantity;
		INSERT INTO CustomerOrder (PatronID, Quantity, Price, PaymentStatus)
		VALUES (@PatronID, @Quantity, @TotalPrice, @PaymentStatus);
		SET @Success = 1;
	END;
END;

CREATE PROCEDURE RetrieveFromSearch
	@ProductName NVARCHAR(50)
AS
BEGIN
	SELECT *
	FROM Product
	WHERE ProductName = @ProductName;
END;