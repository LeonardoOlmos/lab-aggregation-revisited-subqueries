-- Leonardo Olmos Saucedo / Lab Aggregation Revisited - Subqueries

USE sakila;

-- 1. Select the first name, last name, and email address of all the customers who have rented a movie.
SELECT DISTINCT C.FIRST_NAME, C.LAST_NAME, C.EMAIL
FROM CUSTOMER C
JOIN RENTAL R
ON R.CUSTOMER_ID = C.CUSTOMER_ID
ORDER BY 1, 2;

-- 2. What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT C1.CUSTOMER_ID, CONCAT(C1.FIRST_NAME, ' ', C1.LAST_NAME) AS CUSTOMER_NAME, S1.AVG_PAYMENT
FROM CUSTOMER C1
JOIN (
	SELECT C.CUSTOMER_ID, AVG(P.AMOUNT) AS AVG_PAYMENT
	FROM CUSTOMER C
	JOIN PAYMENT P
	ON P.CUSTOMER_ID = C.CUSTOMER_ID
	GROUP BY C.CUSTOMER_ID) S1 
ON C1.CUSTOMER_ID = S1.CUSTOMER_ID;

/* 3. Select the name and email address of all the customers who have rented the "Action" movies.
   Write the query using multiple join statements
   Write the query using sub queries with multiple WHERE clause and IN condition
   Verify if the above two queries produce the same results or not
*/
SELECT DISTINCT C.FIRST_NAME, C.LAST_NAME, C.EMAIL
FROM CUSTOMER C
JOIN RENTAL R
ON R.CUSTOMER_ID = C.CUSTOMER_ID
JOIN INVENTORY I
ON I.INVENTORY_ID = R.INVENTORY_ID
JOIN FILM F 
ON F.FILM_ID = I.FILM_ID
JOIN FILM_CATEGORY FC
ON FC.FILM_ID = F.FILM_ID
JOIN CATEGORY CA
ON CA.CATEGORY_ID = FC.CATEGORY_ID
WHERE LOWER(CA.NAME) = 'action'
ORDER BY 1, 2;


/* 4. Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
   If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
*/
SELECT P.CUSTOMER_ID, P.STAFF_ID, P.RENTAL_ID, P.AMOUNT, 
	CASE
		WHEN P.AMOUNT < 2 THEN 'low'
        WHEN P.AMOUNT >= 2 AND P.AMOUNT <= 4 THEN 'medium'
        ELSE 'high'
	END AS CLASS
FROM PAYMENT P
ORDER BY 1, 4;