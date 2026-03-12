## Case Study Questions

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

```sql

























































