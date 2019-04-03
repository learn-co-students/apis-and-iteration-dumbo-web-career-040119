require 'rest-client'
require 'json'
require 'pry'



def get_character_movies_from_api(character_name)
  all_character_films = []
  count = 0
  while all_character_films.empty?
    count += 1
  response_string = RestClient.get("http://www.swapi.co/api/people/?page=#{count}")
  response_hash = JSON.parse(response_string)
  response_hash["results"].select do |info_hash|
     if info_hash["name"].downcase == character_name
       film_list = info_hash["films"]
       film_list.each do |url|
       film_string = RestClient.get(url)
          film_response_hash = JSON.parse(film_string)
         all_character_films << film_response_hash
       end
      end
    end
  end
  return all_character_films
end

# <!---- with swapi search hack ---->

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

# <!---- END with swapi search hack ---->

def print_movies(films)
  films.each do |movie_info|
    puts movie_info["title"]
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS
# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
