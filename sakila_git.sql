USE sakila;
-- select * from actor;
-- SELECT a.first_name, a.last_name From actor a;

-- select upper(concat(a.first_name, ' ',a.last_name))
-- AS'Actor Name' FROM actor a limit 10;
-- SELECT * FROM payment;

-- select concat('$', p.amount)'Payment amount',
-- date_format(p.payment_date,'%d%m%y')'Payment Date'
-- from payment p limit 10;

-- select * from actor;

-- select a.actor_id, a.first_name, a.last_name from
-- actor a where a.first_name = 'Joe'; 

-- select a.actor_id, a.first_name, a.last_name from
-- actor a where a.first_name != 'Joe';

-- select * from payment p where p.amount>=11;

-- # Contain gen in the name
-- select a.actor_id, a.first_name, a.last_name 
-- from actor a where a.last_name like '%GEN%';

-- -- starting with later
-- select a.actor_id, a.first_name, a.last_name from
-- actor a where a.last_name like'A%';

-- select a.actor_id, a.first_name, a.last_name from
-- actor a where a.last_name like'%T';

-- select a.first_name, a.last_name from actor a
-- where last_name like '%GEN%' and first_name like'J%';

-- select a.first_name, a.last_name from actor a
-- where last_name like 'A%' or last_name like'B%';

-- select c.country_id, c.country from country c where
-- c.country = 'Afghanistan' or 'Bangladesh' or 'China';

-- select c.country_id, c.country from country c where
-- c.country in ('Afghanistan','Bangladesh','China');


-- -- Joining tables
-- select * from address;
-- select * from staff;

-- select s.first_name, s.last_name, a.address
-- from staff s join address a on 
-- s.address_id = a.address_id;

-- select sum(p.amount) as 'Payment after 2006' from payment p
-- where p.payment_date >='2006-01-01';

select * from address;
select * from customer;
select * from store;
select * from payment;

select a.address, avg(p.amount)'Avg payment' from
payment p 
left join customer c on c.customer_id = p.customer_id
left join  store s on s.store_id = c.store_id
left join address a on a.address_id = s.address_id
group by a.address;


select a.address, avg(p.amount)'Avg payment' from
payment p 
left join customer c on c.customer_id = p.customer_id
left join  store s on s.store_id = c.store_id
left join address a on a.address_id = s.address_id
group by a.address, a.district;