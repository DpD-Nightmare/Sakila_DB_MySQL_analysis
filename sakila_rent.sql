SELECT * FROM sakila.rental;

#Dispplay name of Customers and number of times rented, who rented more than 2 times afterJuly month in year 2005
select * from payment;
select * from customer;

select count(1), concat(c.first_name, ' ', c.last_name) 'custormer_name', r.rental_date 
from customer c  join rental r on r.customer_id = c.customer_id 
where date_format(r.rental_date,'%b') > '2005 - July' group by c.first_name having count(*)>50;