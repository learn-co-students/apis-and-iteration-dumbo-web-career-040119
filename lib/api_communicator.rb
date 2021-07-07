require 'rest-client'
require 'json'
require 'pry'

def character_page(i)
  response_string = RestClient.get("http://www.swapi.co/api/people/?page=#{i}")
  response_hash = JSON.parse(response_string.body)
end

def get_character_movies_from_api(character_name)
  i = 1
  find_character = nil
  until find_character != nil
    find_character = character_page(i)["results"].find {|character_data| character_data["name"].downcase == character_name}
    i += 1
    if i == 10
      puts "That is not a Star Wars character"
      return
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
  if films == nil
    return
  end

  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
