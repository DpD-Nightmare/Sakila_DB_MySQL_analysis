##Performing basic SQL Tasks
use sakila;

-- Q1 Which actors have the first name ‘Scarlett’
select * from actor a where a.first_name like 'Scarlett';

-- Q2 Which actors have the last name ‘Johansson’
select * from actor a where a.last_name like 'Johansson';

-- How many distinct actors last names are there?
select count(distinct(a.last_name)) as 'Total Unique last names' from actor a;

-- Which last names are not repeated?
select distinct(a.last_name) as 'Unique last name' from actor a;

--  Which last names appear more than once?
select a.last_name, count(a.actor_id) as cnt from actor a
group by a.last_name Having cnt >1;

-- Which actor has appeared in the most films?
select concat(a.first_name, ' ',a.last_name) as'Actor', 
count(fa.actor_id) as cnt from actor a left join film_actor fa 
on a.actor_id = fa.actor_id group by 'Actor' order by cnt desc
limit 1;

-- Is ‘Academy Dinosaur’ available for rent from Store 1?
select f.title, s.store_id from film f left join inventory i 
on f.film_id=i.film_id left join store s on i.store_id = s.store_id
where f.title like'Academy Dinosaur' and s.store_id like'1' limit 1;

-- Insert a record to represent Mary Smith renting 
-- ‘Academy Dinosaur’ from Mike Hillyer at Store 1 today .
insert into rental (rental_date, inventory_id, customer_id, staff_id)
values (NOW(), 1, 1, 1);

-- When is ‘Academy Dinosaur’ due?
select f.rental_duration from film f where f.film_id = 1;

select r.rental_id from rental r order by r.rental_id desc limit 1;

select r.rental_date, r.rental_date+interval(
select f.rental_duration from film f where f.film_id = 1) day as due_date
from rental r where r.rental_id = (select rental_id from rental order by 
rental_id desc limit 1);


-- What is that average running time of all the films in the sakila DB?
select avg(length) as avg_lengeth from film;

-- What is the average running time of films by category?
select avg(f.length)as AVG_Mocie_lenght, c.name from film f left join film_category fc
on f.film_id = fc.film_id left join category c 
on fc.category_id = c.category_id group by c.name 
order by avg(f.length) desc;

-- Use JOIN to display the first and last names, as well as the address, of each staff 
-- member. Use the tables staff and address:
select concat(s.first_name,' ', s.last_name) as 'Staff Name', a.address from
staff s left join address a on s.address_id = a.address_id;

-- Use JOIN to display the total amount rung up by each staff member in August of 2005. 
-- Use tables staff and payment.
select concat(s.first_name,' ', s.last_name) as 'Staff Name', 
sum(p.amount) as Sale_made, p.payment_date from staff s 
left join payment p on s.staff_id = p.staff_id 
where p.payment_date like '2005-08%' group by p.staff_id;

-- List each film and the number of actors who are listed for that film. 
-- Use tables film_actor and film. Use inner join.
select f.title, concat(a.first_name, last_name) as 'Actor' from film f left join
film_actor fa on f.film_id = fa.film_id left join actor a on a.actor_id = fa.actor_id
group by f.title;

select f.title, count(fa.actor_id) as 'Actor' from film f left join
film_actor fa on f.film_id = fa.film_id group by f.title;

-- How many copies of the film Hunchback Impossible exist in the inventory system?
select f.title as name, count(i.inventory_id) as 'Count' from film f
left join inventory i on f.film_id = i.film_id where f.title 
like 'Hunchback Impossible' group by f.film_id;

-- Using the tables payment and customer and the JOIN command, list the total 
-- paid by each customer. List the customers alphabetically by last name:
select concat(c.first_name, ' ', c.last_name)as Customer_name, 
sum(p.amount) as Total_Shopping from customer c left join payment p
on c.customer_id = p.customer_id group by p.customer_id order by c.last_name;

-- The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
-- As an unintended consequence, films starting with the letters K and Q have 
-- also soared in popularity. Use subqueries to display the titles of movies 
-- starting with the letters K and Q whose language is English. 

select f.title from film f left join language l 
on l.language_id = f.language_id where f.title 
like 'K%' or 'Q%' and l.name = 'English';

-- Use subqueries to display all actors who appear in the film ACADEMY DINOSAUR.
select concat(first_name, ' ', last_name) as 'Actor in ACADEMY DINOSAUR' 
from actor
where actor_id in (select actor_id  from film_actor where film_id = 
(select film_id from film where title = 'ACADEMY DINOSAUR'));

-- or 
 select concat(a.first_name, ' ', a.last_name) as 'Actor in ACADEMY DINOSAUR' 
from actor a left join film_actor fa on fa.actor_id = a.actor_id
left join film f on f.film_id = fa.film_id where f.title ='ACADEMY DINOSAUR';

-- You want to run an email marketing campaign in Canada, for which you will 
-- need the names and email addresses of all Canadian customers. Use joins to 
-- retrieve this information.
select concat(c.first_name, ' ', c.last_name) as Customer_name, co.Country from 
customer c left join address a on a.address_id = c.address_id
left join city ci on ci.city_id = a.city_id
left join country co on co.country_id = ci.country_id
where co. country = 'Canada';

-- Sales have been lagging among young families, and you wish to target all 
-- family movies for a promotion. Identify all movies categorized as famiy films.
select f.title as "Movie_title" from film f
left join film_category fc on fc.film_id = f.film_id
left join category c on c.category_id = fc.category_id
where c.name like 'Family';

-- Display the most frequently rented movies in descending order
select f.title as 'Movie', count(r.rental_date) as 'Time Rented'
from film f left join inventory i on i.film_id = f.film_id
left join Rental r on r.inventory_id= i.inventory_id
group by f.title order by count(r.rental_date) desc;

-- Write a query to display how much business, in dollars, each store brought in.
select concat(c.city, ' ', co.country)'Location', 
s.store_id 'STORE ID', sum(p.amount)'Total Business' 
from payment p left join rental r on p.rental_id = r.rental_id
left join inventory i on i.inventory_id = r.inventory_id
left join store s on s.store_id = i.store_id
left join address a on a.address_id= s.address_id
left join city c on c.city_id = a.city_id
left join country co on co.country_id = c.country_id
group by s.store_id;

-- Write a query to display for each store its store ID, city, and country.
select s.store_id 'STORE-ID', c.city 'CITY', cy.country 'COUNTRY'
from store s left join address a on s.address_id = a.address_id
left join city c on c.city_id = a.city_id
left join country cy on cy.country_id= c.country_id
order by s.store_id;

--  List the top five genres in gross revenue in descending order.
select c.name 'Genres', sum(p.amount)'Total Business'
from payment p left join rental r on r.rental_id=p.rental_id
left join inventory i on i.inventory_id = r.inventory_id
left join film_category fc on fc.film_id = i.film_id
left join category c on c.category_id = fc.category_id
group by c.name
order by sum(p.amount) desc
limit 5;

-- In your new role as an executive, you would like to have an easy 
-- way of viewing the Top five genres by gross revenue. Use the solution 
-- from the problem above to create a view.
create view top_5_geners as
select c.name 'Genres', sum(p.amount)'Total Business'
from payment p left join rental r on r.rental_id=p.rental_id
left join inventory i on i.inventory_id = r.inventory_id
left join film_category fc on fc.film_id = i.film_id
left join category c on c.category_id = fc.category_id
group by c.name
order by sum(p.amount) desc
limit 5;

select * from top_5_geners;