-- Insert Sample Data into Authors
INSERT INTO Authors (Name, BirthDate, Nationality) VALUES 
('J.K. Rowling', '1965-07-31', 'British'),
('George Orwell', '1903-06-25', 'British');
-- Insert Sample Data into Books
INSERT INTO Books (Title, ISBN, PublishedDate, AuthorId, Genre, QuantityAvailable,TotalCopies ,Price) VALUES 
('Harry Potter and the Sorcerer''s Stone', '9780747532699', '1965-07-31', 1, 'Fantasy', 5,6,100),
('1984', '9780451524935', '1990-05-31', 2, 'Dystopian',6,7,50);

-- Insert Sample Data into Users
INSERT INTO Borrowers (FullName, Email, PhoneNumber) VALUES 
('Alice Johnson', 'alice@example.com', '123-456-7890'),
('Bob Smith', 'bob@example.com', '987-654-3210');

-- Insert Sample Data into BorrowRecords
INSERT INTO BorrowTransactions (BorrowerId, BookId, BorrowDate, DueDate) VALUES 
(1, 1, '2024-01-10', '2024-02-10'),
(2, 2, '2024-01-15', '2024-02-15');
