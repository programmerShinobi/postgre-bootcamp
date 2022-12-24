-- SUBQUERY
SELECT * FROM departments WHERE location_id IN
	(SELECT location_id FROM locations loc, countries cou WHERE loc.country_id = cou.country_id);

	
-- JOIN
SELECT * FROM departments dep
INNER JOIN locations loc ON loc.location_id = dep.location_id;
