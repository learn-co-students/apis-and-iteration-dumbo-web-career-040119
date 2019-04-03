require 'rest-client'
require 'json'
require 'pry'



def get_character_movies_from_api(character_name)
  all_character_films = []
  count = 0
  while all_character_films.length == 0 do
      count += 1
      response_string = RestClient.get("http://www.swapi.co/api/people/?page=#{count}")
      response_hash = JSON.parse(response_string)
      #binding.pry
  
      response_hash["results"].select do |info_hash|
        if info_hash["name"].downcase == character_name
        
          film_list = info_hash["films"]
          film_list.each do |url|
          film_string = RestClient.get(url)
          film_response_hash = JSON.parse(film_string)
          all_character_films << film_response_hash
          
        end
        #else will not work because it accounts for situations it doesnt work for
      end
      #count += 1
    end
  end
  return all_character_films
end
 # response_hash["results"].find do |info_hash|
      #   info_hash["name"] = character_name
      #   binding.pry
      # end
###### with swapi search hack

# def get_character_movies_from_api(character_name)
#   all_character_films = []
#   response_string = RestClient.get("http://www.swapi.co/api/people/?search=#{character_name}")
#   response_hash = JSON.parse(response_string)
#   response_hash["results"].each do |info_hash|
#        film_list = info_hash["films"]
#        film_list.each do |url|
#        film_string = RestClient.get(url)
#           film_response_hash = JSON.parse(film_string)
#          all_character_films << film_response_hash
#     end
#   end
#   return all_character_films
# end
  #exitqbinding.pry
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
  films.each do |movie_info|
    puts movie_info["title"]
  end
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  #binding.pry
  print_movies(films)
end

## BONUS
# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
