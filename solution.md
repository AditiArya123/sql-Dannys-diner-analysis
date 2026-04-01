# Case Study Questions

1. What is the total amount each customer spent at the restaurant?
2. How many days has each customer visited the restaurant?
3. What was the first item from the menu purchased by each customer?
4. What is the most purchased item on the menu and how many times was it purchased by all customers?
5. Which item was the most popular for each customer?
6. Which item was purchased first by the customer after they became a member?
7. Which item was purchased just before the customer became a member?
8. What is the total items and amount spent for each member before they became a member?
9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?


**Bonus question**:


i. Join all the things

ii. Rank all the things


-----


## Solutions:

Let's collaborate on running the queries using MySQL on [DB Fiddle](https://www.db-fiddle.com/). It'll be fantastic to team up and tackle the questions together!!

----

### 1. What is the total amount each customer spent at the restaurant?
Helps identify high-value customers and revenue contribution by user segment.
```sql
select s.customer_id, sum(m.price) as total_amount
from menu m join sales s on m.product_id=s.product_id
group by 1
order by 1;
```

### Result set:

| customer_id | total_sales |
| ----------- | ----------- |
| A           | 76          |
| B           | 74          |
| C           | 36          |

---

### 2. How many days has each customer visited the restaurant?
Measures customer engagement and visit frequency to understand loyalty patterns.
```sql
select customer_id, count(distinct order_date) as visit_count
from sales
group by 1
order by 1;
```

### Result set:

| customer_id | visit_count |
| ----------- | ----------- |
| A           | 4           |
| B           | 6           |
| C           | 2           |

---

### 3. What was the first item from the menu purchased by each customer?
Identifies first-touch product experience, which can influence retention and preferences.
```sql
select s.customer_id, m.product_name
from sales s
join menu m 
on s.product_id=m.product_id
where s.order_date in (
  select min(order_date)
  from sales
  where customer_id=s.customer_id
  )
  order by customer_id;
```

### Result set:

| customer_id | Product_name |
| ----------- | ------------ |
| A           | Sushi        |
| A           | Curry        |
| B           | Curry        |
| C           | Ramen        |
| C           | Ramen        |

---

### 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
Highlights top-performing products driving overall demand and revenue.
```sql
select m.product_name, count(*) as purchase_count
from sales s
join menu m
on s.product_id=m.product_id
group by m.product_name
order by purchase_count desc
limit 1;
```
### Result set:

| product_name | purchase_count |
| ------------ | -------------- |
| Ramen        | 8              |

---

### 5. Which item was the most popular for each customer?
Reveals individual customer preferences for personalization and targeted recommendations.
```sql
SELECT s.customer_id, m.product_name, COUNT(*) AS order_count
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
GROUP BY s.customer_id, m.product_name
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM sales s2
        WHERE s2.customer_id = s.customer_id
        GROUP BY s2.product_id
    ) t
);
```
#### Result set:

| customer_id | product_name | order_count |
| ----------- | ------------ | ----------- |
| A           | ramen        | 3           |
| B           | ramen        | 2           |
| B           | curry        | 2           |
| B           | sushi        | 2           |
| C           | ramen        | 3           |


### 6. Which item was purchased first by the customer after they became a member?

```sql
SELECT customer_id, product_name, order_date
FROM (
    SELECT s.customer_id,
           m.product_name,
           s.order_date,
           ROW_NUMBER() OVER (
               PARTITION BY s.customer_id 
               ORDER BY s.order_date
           ) AS rn
    FROM sales s
    JOIN members mem
        ON s.customer_id = mem.customer_id
    JOIN menu m
        ON s.product_id = m.product_id
    WHERE s.order_date >= mem.join_date
) t
WHERE rn = 1;
```
#### Result set:

| customer_id | product_name | order_date |
| ----------- | ------------ | ---------- |
| A           | curry        | 2021-01-07 |
| B           | sushi        | 2021-01-11 |

### 7. Which item was purchased just before the customer became a member?

```sql
SELECT customer_id, product_name, order_date
FROM (
    SELECT s.customer_id,
           m.product_name,
           s.order_date,
           ROW_NUMBER() OVER (
               PARTITION BY s.customer_id 
               ORDER BY s.order_date DESC
           ) AS rn
    FROM sales s
    JOIN members mem
        ON s.customer_id = mem.customer_id
    JOIN menu m
        ON s.product_id = m.product_id
    WHERE s.order_date < mem.join_date
) t
WHERE rn = 1;
```
### result
| customer_id | product_name | order_date  |
| ----------- | ------------ | ----------- |
| A           | sushi        | 2021-01-01  |
| A           | curry        | 2021-01-01  |
| B           | sushi        | 2021-01-04  |























