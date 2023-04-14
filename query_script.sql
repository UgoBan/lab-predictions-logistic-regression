use sakila;

select distinct f.title, f.length, f.rating, r.rental_id, p.amount from film f
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment p
on r.rental_id = p.rental_id;

SELECT DISTINCT f.title, f.length, f.rating, AVG(p.amount) as amount
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.title, f.length, f.rating;

SELECT DISTINCT f.title, f.length, f.rating, c.name AS category, round(AVG(p.amount),2) AS avg_amount
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
LEFT JOIN payment p ON r.rental_id = p.rental_id
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id
GROUP BY f.title, f.length, f.rating, c.name;




SELECT f.title,
       CASE WHEN EXISTS (SELECT 1
                         FROM inventory i
                         JOIN rental r ON i.inventory_id = r.inventory_id
                         WHERE f.film_id = i.film_id
                           AND MONTH(r.rental_date) = 5)
           THEN 'Yes'
           ELSE 'No'
       END AS rented_in_may
FROM film f;
