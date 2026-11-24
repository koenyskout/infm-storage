SELECT title, name
FROM movies INNER JOIN movie_actor ON
movie_actor.movie_id = movies.movie_id
INNER JOIN actors ON
actors.actor_id = movie_actor.actor_id
ORDER BY title, name