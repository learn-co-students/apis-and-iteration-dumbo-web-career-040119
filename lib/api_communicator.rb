
require 'rest-client'
require 'json'
require 'pry'

# iterate over the response hash to find the collection of `films` for the given
#   `character`
# collect those film API urls, make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `print_movies`
#  and that method will do some nice presentation stuff like puts out a list
#  of movies by title. Have a play around with the puts with other info about a given film.

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get("https://www.swapi.co/api/people/")
  response_hash = JSON.parse(response_string.body)

while response_string
  find_character = response_hash["results"].find do |character_data|
    if character_name == character_data["name"].downcase
        character_data["films"]
        film = character_data["films"]
      return film
      end
    end

    if response_string = RestClient.get(response_hash["next"])
       response_hash = JSON.parse(response_string.body)
    else
      nil
    end
   end
end


def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  film_url = films.map do |film|
    response_string = RestClient.get(film)
    response_hash = JSON.parse(response_string.body)
      title = response_hash["title"]
    puts title
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
