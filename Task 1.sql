CREATE DATABASE library;

USE library;

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY IDENTITY(1,1),  
    Name VARCHAR(150),    -- First Name of the author
    BirthDate DATE,
    Nationality VARCHAR(50)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),  
    Title VARCHAR(150),    -- Title of the book
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    PublishedDate DATE,
    Genre VARCHAR(50),
    TotalCopies INT,
    QuantityAvailable INT,
    AuthorID INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Borrowers (
    BorrowerID INT PRIMARY KEY IDENTITY(1,1),  
    FullName VARCHAR(255),
    Email VARCHAR(150) UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255),
    MembershipDate DATE
);

CREATE TABLE BorrowerTransactions (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),  
    BookID INT,
    BorrowerID INT,
    BorrowDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    Status VARCHAR(10) CHECK (Status IN ('Borrowed', 'Returned')) DEFAULT 'Borrowed',
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);
