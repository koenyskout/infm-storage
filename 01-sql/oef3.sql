SELECT title, release_year FROM movies 
WHERE release_year < 2000
AND genre = 'Sci-Fi'
ORDER BY title;