
/* Would the database be able to tell which other customers had bought 
the same product a given customer or prospective customer had bought 
or was considering buying?*/

/*
In this query example, given customer is customer with the cust_id=12.
*/

SELECT ord.cust_id , cust.First_Name, cust.Last_Name
FROM   orders ord inner join Customer cust
on ord.Cust_ID=cust.Cust_ID
WHERE  ord.cust_id != 12 
       AND prod_id IN(SELECT prod_id 
                      FROM   orders 
                      WHERE  cust_id = 12 
                      UNION 
                      SELECT prod_id 
                      FROM   wish_list 
                      WHERE  cust_id = 12); 

/*2. Would the database be able to tell even something
deeper,that is, what other products other
customers bought who also bought the product the customer just bought (that is, an opportunity for
cross-selling)?*/

/* Answer:
In this example customer with cust_id=12 has bought prod_id 123. 
This query gives all the products that other customers bought 
who also bought the product with the prod_id=123*/

SELECT prod_id 
FROM   orders 
WHERE  cust_id IN (SELECT cust_id 
                   WHERE  prod_id = 123 
                          AND cust_id != 12); 
						  
/*Question 3: Would he be able to find other customers with at
least three interests that overlap with those of a
given customer so that he can suggest to these
other customers other products they might want to
purchase?*/

/*

In this example, we are finding other customers who has at least three overlapping interests
with customer where cust_id=12.

*/

SELECT   cust_id, 
         Count(interest) AS no_of_interest 
FROM     interest 
WHERE    interest IN 
         ( 
                SELECT interest 
                FROM   interest 
                WHERE  cust_id = 12) x 
GROUP BY cust_id 
HAVING   no_of_interest >= 3;