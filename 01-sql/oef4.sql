SELECT title, name, release_year FROM 
movies INNER JOIN directors ON 
movies.director_id = directors.director_id
ORDER BY directors.name, release_year;