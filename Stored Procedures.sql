/*a.	Create a stored procedure to enter new books with author, 
if author already exist then use current author and if not exist, create new author,
 and assign to book and use it to insert more data in books and authors tables.*/
 
 CREATE PROCEDURE AddNewBook
    @Name VARCHAR(150),
    @BirthDate DATE,
    @Nationality VARCHAR(50),
    @Title VARCHAR(150),
    @ISBN VARCHAR(20),
    @PublishedDate DATE,
    @Genre VARCHAR(50),
    @TotalCopies INT,
    @QuantityAvailable INT,
    @Price DECIMAL(10, 2)
AS
BEGIN
    DECLARE @AuthorID INT;

   --Check if the author exists, if not --> NULL
     SELECT @AuthorID = CASE 
                        WHEN EXISTS (SELECT 1 FROM Authors WHERE Name = @Name AND BirthDate = @BirthDate AND Nationality = @Nationality) 
                        THEN (SELECT AuthorID FROM Authors WHERE Name = @Name AND BirthDate = @BirthDate AND Nationality = @Nationality)
                        ELSE NULL 
                        END;
    -- 2. If author not found, insert new author
    IF @AuthorID IS NULL
    BEGIN
        INSERT INTO Authors (Name, BirthDate, Nationality)
        VALUES (@Name, @BirthDate, @Nationality);
        SET @AuthorID = SCOPE_IDENTITY();
    END

    -- 3. Insert book with the author
    INSERT INTO Books (Title, ISBN, PublishedDate, Genre, TotalCopies, QuantityAvailable, AuthorID, Price)
    VALUES (@Title, @ISBN, @PublishedDate, @Genre, @TotalCopies, @QuantityAvailable, @AuthorID, @Price);
END;



/*b.	Create a stored procedure that takes author id and price %
 increase as parameter uses a cursor to get all books for this author and update books price with this %*/


CREATE PROCEDURE ChangeBooksPrices
    @AuthorID INT,
    @IncreasePercentage DECIMAL(4, 2) 
AS
BEGIN
    DECLARE @BookID INT;
    DECLARE @CurrentPrice DECIMAL(10, 2);
    DECLARE @AddedPrice DECIMAL(10, 2);
    DECLARE @NewPrice DECIMAL(10, 2);


    -- Declare the cursor to fetch books for the given author
    DECLARE BooksCursor CURSOR FOR
    SELECT BookID, Price
    FROM Books
    WHERE AuthorID = @AuthorID;

    -- Open the cursor
    OPEN BooksCursor;

    -- Fetch the first book
    FETCH NEXT FROM BooksCursor INTO @BookID, @CurrentPrice;

    -- Loop through all books for the author
    WHILE @@FETCH_STATUS = 0
    BEGIN
        
        --UPDATE BOOK PRICE
        SET @AddedPrice=@CurrentPrice *(@IncreasePercentage / 100)
        SET @NewPrice = @AddedPrice+ @CurrentPrice;
        UPDATE Books
        SET Price = @NewPrice
        WHERE BookID = @BookID;

        -- Fetch the next book
        FETCH NEXT FROM BooksCursor INTO @BookID, @CurrentPrice;
    END;
    CLOSE BooksCursor;
    DEALLOCATE BooksCursor;
END;


