--Create a view to get number of books borrowed by each user. 

CREATE VIEW BorrowedBooksNumbers AS
SELECT bt.BorrowerID,b.FullName AS BorrowerFullName, COUNT(bt.BookID) AS BookCount
FROM BorrowerTransactions bt LEFT JOIN Borrowers b ON bt.BorrowerId=b.BorrowerId
WHERE bt.Status = 'Borrowed' 
GROUB BY b.BorrowerID, b.FullName;


--Create a Query to find books never borrowed.

SELECT BookID,Title
FROM Books
WHERE BookID NOT IN (SELECT BookID FROM BorrowerTransactions)