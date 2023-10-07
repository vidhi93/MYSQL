-- Create the Books table
CREATE TABLE Books (
  book_id INT PRIMARY KEY,
  title VARCHAR(100),
  author VARCHAR(100),
  genre VARCHAR(50),
  price DECIMAL(8, 2)
);

-- Insert data into the Books table
INSERT INTO Books (book_id, title, author, genre, price)
VALUES
  (1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 10.99),
  (2, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 12.50),
  (3, '1984', 'George Orwell', 'Science Fiction', 8.99),
  (4, 'Pride and Prejudice', 'Jane Austen', 'Romance', 9.99),
  (5, 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 11.25);

-- Create the Customers table
CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  city VARCHAR(50),
  country VARCHAR(50)
);

-- Insert data into the Customers table
INSERT INTO Customers (customer_id, name, email, city, country)
VALUES
  (1, 'John Smith', 'john@example.com', 'London', 'UK'),
  (2, 'Jane Doe', 'jane@example.com', 'New York', 'USA'),
  (3, 'Michael Johnson', 'michael@example.com', 'Sydney', 'Australia'),
  (4, 'Sophia Rodriguez', 'sophia@example.com', 'Paris', 'France'),
  (5, 'Luis Hernandez', NULL, 'Mexico City', 'Mexico');

-- Create the Orders table
CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  total_amount DECIMAL(10, 2),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert data into the Orders table
INSERT INTO Orders (order_id, customer_id, order_date, total_amount)
VALUES
  (1, 1, '2022-01-15', 50.99),
  (2, 2, '2022-02-20', 75.50),
  (3, 3, '2022-03-10', 30.75),
  (4, 4, '2022-04-05', 22.99),
  (5, 5, '2022-05-12', 15.25);

-- Create the Order_Items table
CREATE TABLE Order_Items (
  order_item_id INT PRIMARY KEY,
  order_id INT,
  book_id INT,
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert data into the Order_Items table
INSERT INTO Order_Items (order_item_id, order_id, book_id, quantity)
VALUES
  (1, 1, 1, 2),
  (2, 2, 3, 1),
  (3, 3, 2, 3),
  (4, 4, 5, 1),
  (5, 5, 4, 2);
  
  select * from orders;
  select * from order_items;
  select * from customers;
  select * from books;
  
  /*  Retrieve all books with a price greater than $10. */
  select title,price
  from books
  where price > 10;
  
  /* Find the total amount spent by each customer in descending order.*/
  select customer_id,total_amount
  from orders
  order by total_amount DESC;
  
  /*Retrieve the top 3 best-selling books based on the total quantity sold. */
  select oi.book_id,b.title,oi.quantity
  from order_items oi
  join books b on b.book_id = oi.book_id
  order by oi.quantity DESC
  limit 3;