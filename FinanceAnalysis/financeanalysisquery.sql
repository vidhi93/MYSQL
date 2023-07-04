CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
City VARCHAR(50) NOT NULL,
State VARCHAR(2) NOT NULL
);

INSERT INTO Customers (CustomerID, FirstName, LastName, City, State)
VALUES (1, 'John', 'Doe', 'New York', 'NY'),
(2, 'Jane', 'Doe', 'New York', 'NY'),
(3, 'Bob', 'Smith', 'San Francisco', 'CA'),
(4, 'Alice', 'Johnson', 'San Francisco', 'CA'),
(5, 'Michael', 'Lee', 'Los Angeles', 'CA'),
(6, 'Jennifer', 'Wang', 'Los Angeles', 'CA');

CREATE TABLE Branches (
BranchID INT PRIMARY KEY,
BranchName VARCHAR(50) NOT NULL,
City VARCHAR(50) NOT NULL,
State VARCHAR(2) NOT NULL
);

INSERT INTO Branches (BranchID, BranchName, City, State)
VALUES (1, 'Main', 'New York', 'NY'),
(2, 'Downtown', 'San Francisco', 'CA'),
(3, 'West LA', 'Los Angeles', 'CA'),
(4, 'East LA', 'Los Angeles', 'CA'),
(5, 'Uptown', 'New York', 'NY'),
(6, 'Financial District', 'San Francisco', 'CA'),
(7, 'Midtown', 'New York', 'NY'),
(8, 'South Bay', 'San Francisco', 'CA'),
(9, 'Downtown', 'Los Angeles', 'CA'),
(10, 'Chinatown', 'New York', 'NY'),
(11, 'Marina', 'San Francisco', 'CA'),
(12, 'Beverly Hills', 'Los Angeles', 'CA'),
(13, 'Brooklyn', 'New York', 'NY'),
(14, 'North Beach', 'San Francisco', 'CA'),
(15, 'Pasadena', 'Los Angeles', 'CA');

CREATE TABLE Accounts (
AccountID INT PRIMARY KEY,
CustomerID INT NOT NULL,
BranchID INT NOT NULL,
AccountType VARCHAR(50) NOT NULL,
Balance DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

INSERT INTO Accounts (AccountID, CustomerID, BranchID, AccountType, Balance)
VALUES (1, 1, 5, 'Checking', 1000.00),
(2, 1, 5, 'Savings', 5000.00),
(3, 2, 1, 'Checking', 2500.00),
(4, 2, 1, 'Savings', 10000.00),
(5, 3, 2, 'Checking', 7500.00),
(6, 3, 2, 'Savings', 15000.00),
(7, 4, 8, 'Checking', 5000.00),
(8, 4, 8, 'Savings', 20000.00),
(9, 5, 14, 'Checking', 10000.00),
(10, 5, 14, 'Savings', 50000.00),
(11, 6, 2, 'Checking', 5000.00),
(12, 6, 2, 'Savings', 10000.00),
(13, 1, 5, 'Credit Card', -500.00),
(14, 2, 1, 'Credit Card', -1000.00),
(15, 3, 2, 'Credit Card', -2000.00);

CREATE TABLE Transactions (
TransactionID INT PRIMARY KEY,
AccountID INT NOT NULL,
TransactionDate DATE NOT NULL,
Amount DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount)
VALUES (1, 1, '2022-01-01', -500.00),
(2, 1, '2022-01-02', -250.00),
(3, 2, '2022-01-03', 1000.00),
(4, 3, '2022-01-04', -1000.00),
(5, 3, '2022-01-05', 500.00),
(6, 4, '2022-01-06', 1000.00),
(7, 4, '2022-01-07', -500.00),
(8, 5, '2022-01-08', -2500.00),
(9, 6, '2022-01-09', 500.00),
(10, 6, '2022-01-10', -1000.00),
(11, 7, '2022-01-11', -500.00),
(12, 7, '2022-01-12', -250.00),
(13, 8, '2022-01-13', 1000.00),
(14, 8, '2022-01-14', -1000.00),
(15, 9, '2022-01-15', 500.00);

select * from customers;
select * from transactions;
select * from branches;
select * from accounts;

/* What are the names of all the customers who live in New York?*/
select firstname,lastname
from customers
where city = 'New York';

/*What is the total number of accounts in the Accounts table?*/
select count(accountid) as 'Total No of Accounts'
from accounts;

/* What is the total balance of all checking accounts?*/
select accounttype,sum(balance) as 'Total Balance'
from accounts
where accounttype = 'checking';

/* What is the total balance of all accounts associated with customers who live in Los Angeles?*/
select c.firstname,c.lastname,a.accounttype,sum(a.balance) as 'Total Balance'
from accounts a 
join customers c on c.customerid = a.customerid
where c.city = 'Los Angeles'
Group by 1,2,3;

/*Which branch has the highest average account balance?*/
select b.branchname,max(a.balance) as 'Highest Balance'
from branches b
join accounts a on a.branchid =b.branchid
Group by b.branchname
Order by max(a.balance) DESC
Limit 1;

/* Which customer has the highest current balance in their accounts?*/
select c.firstname,c.lastname,max(a.balance) as 'Highest Balance'
from customers c
join accounts a on a.customerid =c.customerid
Group by 1,2
Order by max(a.balance) DESC
Limit 1;

/* Which customer has made the most transactions in the Transactions table?*/

select c.firstname,c.lastname,count(t.transactionid) as 'Maximum Transactions'
from customers c
join accounts a on a.customerid =c.customerid
join transactions t on t.accountid =a.accountid
Group by 1,2
Order by count(t.transactionid) DESC
Limit 2;

/*Which branch has the highest total balance across all of its accounts? */
select b.branchname,sum(balance) as 'Highest Total Balance'
from branches b
join accounts a on a.branchid =b.branchid
Group by 1
Order by sum(balance) DESC
Limit 1;

/*Which customer has the highest total balance across all of their accounts, including savings and checking accounts? */
select b.branchname,sum(balance) as 'Highest Total Balance'
from branches b
join accounts a on a.branchid =b.branchid
where a.accounttype = 'savings' and a.accounttype = 'checking'
Group by 1;

/* Which branch has the highest number of transactions in the Transactions table?*/
select b.branchname,count(t.transactionid) as 'Highest No of Transactions'
from branches b
join accounts a on a.branchid =b.branchid
join transactions t on t.accountid =a.accountid
Group by 1
Order by count(t.transactionid) DESC
Limit 2;