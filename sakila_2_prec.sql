#Find out all Sci-Fi movies which has lenghtgreater than 60 minutes and are in English
Use sakila;
Select * from film;
Select * from category;
Select * from language;
Select * from film_category;

Select f.title, fc.film_id, c.name  from film_category fc join category c 
on fc. category_id = c.category_id join film f on f.film_id = fc.film_id
join language l on l.language_id = f.language_id
where c.name = 'Sci-Fi' and l.name = 'English' and f.length>60;

 