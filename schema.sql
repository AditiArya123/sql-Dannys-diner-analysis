CREATE DATABASE dannys_diner;
USE dannys_diner;

CREATE TABLE sales (
customer_id VARCHAR(1),
order_date DATE,
product_id INT
);

CREATE TABLE menu (
product_id INT,
product_name VARCHAR(20),
price INT
);

CREATE TABLE members (
customer_id VARCHAR(1),
join_date DATE
);
INSERT INTO sales VALUES
('A','2021-01-01',1),
('A','2021-01-01',2),
('A','2021-01-07',2),
('A','2021-01-10',3),
('A','2021-01-11',3),
('A','2021-01-11',3),
('B','2021-01-01',2),
('B','2021-01-02',2),
('B','2021-01-04',1),
('B','2021-01-11',1),
('B','2021-01-16',3),
('B','2021-02-01',3),
('C','2021-01-01',3),
('C','2021-01-01',3),
('C','2021-01-07',3);

insert into menu values 
(1, 'Sushi', '10'),
(2, 'Curry', '15'),
(3, 'Ramen', '12');

insert into members values
('A', '2021-01-07'),
('B', '2021-01-09');
  
