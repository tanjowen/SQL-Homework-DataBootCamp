use sakila;

-- Part 1 --
select * from actor;
select first_name, last_name
from actor;

select concat(first_name, ' ', last_name) as 'Actor Name'
from actor;

-- Part 2 --
select actor_id, first_name, last_name from actor
where first_name = "Joe";

select actor_id, first_name, last_name from actor
where last_name like "%Gen%";

select actor_id, first_name, last_name from actor
where last_name like "%Li%"
order by last_name, first_name;

select * from country;
select country_id, country from country 
where country in ("Afghanistan", "Bangladesh", "China");

-- Part 3 --
select * from actor;
alter table actor
add column description blob 
after last_name;

alter table actor
drop column description; 

-- Part 4 --
select * from actor;
select last_name, count(last_name) as 'Count'
from actor
group by last_name;

select last_name, count(last_name) as 'Count'
from actor
group by last_name
having count>=2;

update actor
set first_name='HARPO'
where first_name='GROUCHO'
and last_name='WILLIAMS';

update actor
set first_name='GROUCHO'
where first_name='HARPO'
and last_name='WILLIAMS';

-- Part 5 --
describe sakila.address;

-- Part 6 --
select * from staff;
select * from address;

select s.first_name, s.last_name, a.address
from staff s
left join address a 
on s.address_id = a.address_id;

select * from payment;
select s.first_name, s.last_name, sum(p.amount) as 'Total'
from staff s
left join payment p 
on s.staff_id = p.staff_id
group by s.first_name, s.last_name;

select * from film_actor;
select * from film;
select f.title, count(a.actor_id) as 'Total'
from film f
inner join film_actor a 
on f.film_id = a.film_id
group by f.title;

select * from inventory;
select f.title, count(i.inventory_id) as 'Total Count'
from film f
inner join inventory i
on f.film_id = i.film_id
where title='HUNCHBACK IMPOSSIBLE';

select * from customer;
select c.first_name, c.last_name, sum(p.amount) as 'Total'
from customer c 
inner join payment p 
on c.customer_id = p.customer_id
group by c.first_name, c.last_name
order by c.last_name;

-- Part 7 --
 select title from film 
 where title like 'K%' or title like 'Q%'
 and language_id=
(
	select language_id 
    from language
    where name='English'
);

select first_name, last_name
from actor 
where actor_id in 
(
	select actor_id
    from film_actor
    where film_id in 
    (
		select film_id
        from film
        where title='ALONE TRIP'
	)
);

select first_name, last_name, email
from customer c 
join address a 
on c.address_id = a.address_id
join city ci 
on a.city_id = ci.city_id
join country co 
on ci.country_id = co.country_id
where co.country_id=20;

select * from category;
select title
from film f
join film_category fc
on f.film_id = fc.film_id
join category c 
on fc.category_id = c.category_id
where c.category_id=8;

select title, count(r.inventory_id) as 'RentedMoviesCount'
from film f 
join inventory i 
on f.film_id = i.film_id
join rental r 
on i.inventory_id = r.inventory_id
group by title
order by RentedMoviesCount desc;

select s.store_id, sum(p.amount)
from payment p 
join staff s 
on p.staff_id = s.staff_id
group by store_id;

select store_id, city, country 
from store s
join address a 
on s.address_id = a.address_id
join city c 
on a.city_id = c.city_id
join country co
on co.country_id = c.country_id;

select c.name as 'Top 5', sum(p.amount) as 'GrossRevenue'
from category c
join film_category fc
on c.category_id = fc.category_id
join inventory i
on fc.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment p 
on r.rental_id = p.rental_id
group by c.name
order by GrossRevenue desc limit 5;

-- Part 8 --
create view topfive as
select c.name as 'Top 5', sum(p.amount) as 'GrossRevenue'
from category c
join film_category fc
on c.category_id = fc.category_id
join inventory i
on fc.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment p 
on r.rental_id = p.rental_id
group by c.name
order by GrossRevenue desc limit 5;

select * from TopFive;

drop view TopFive;