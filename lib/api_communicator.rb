require 'rest-client'
require 'json'
require 'pry'

def get_movie_links(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  if response_hash["results"][0]["name"].downcase == character_name
    films = response_hash["results"][0]["films"]
    get_film_names(films)
  end
end

def get_film_names(films)

  films.collect! do |film_url|
    response_film_url = RestClient.get(film_url)

    response_film_url_hash = JSON.parse(response_film_url)

    response_film_url_hash["title"]

  end

end

get_movie_links("luke skywalker")




  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.


def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |title|
    puts title
  end
end

def show_character_movies(character)
  films = get_movie_links(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
