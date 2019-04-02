require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get("http://www.swapi.co/api/people/")
  response_hash = JSON.parse(response_string.body)
  #puts JSON.pretty_generate(response_hash)


  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  find_character = response_hash["results"].find do |character_data|
    character_data["name"] == character_name
  end
  i = 1
  until find_character != nil
    i += 1
    response_string = RestClient.get("http://www.swapi.co/api/people/?page=#{i}")
    response_hash = JSON.parse(response_string.body)

    find_character = response_hash["results"].find do |character_data|
      character_data["name"] == character_name
    end
  end
  find_character["films"]
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  output = films.map do |link|
    movie_string = RestClient.get(link)
    movie_hash = JSON.parse(movie_string.body)
    movie_hash["title"]
  end
  puts output
end

# def print_movies(films)
#   # some iteration magic and puts out the movies in a nice list
#   films.select do |link|
#     movie_string = RestClient.get(link)
#     movie_hash = JSON.parse(movie_string.body)
#     puts movie_hash["title"]
#   end
# end

def show_character_movies(character)
  films = get_character_movies_from_api(character)

  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
