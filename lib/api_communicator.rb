require 'rest-client'
require 'json'
require 'pry'

def jsonify
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
end

def find_character(hash_data, character_name)
  character_array = hash_data["results"].find do |character_data|
    character_data["name"].downcase == character_name
  end
end

def get_films(film_arr)
  movie_arr = film_arr["films"].map do |film|
    film_data = RestClient.get("#{film}")
    film_response = JSON.parse(film_data)
    film_response["title"]
  end
  movie_arr
end

def get_character_movies_from_api(character_name)
  #make the web request
  characters_arr = find_character(jsonify,character_name)
  films_arr = get_films(characters_arr)
  #films_arr
end

def print_movies(films)
  films.each_with_index do |film, index|
    puts "#{index += 1} #{film}"
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?



# iterate over the response hash to find the collection of `films` for the given
#   `character`
# collect those film API urls, make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `print_movies`
#  and that method will do some nice presentation stuff like puts out a list
#  of movies by title. Have a play around with the puts with other info about a given film.
#puts JSON.pretty_generate(response_hash)
