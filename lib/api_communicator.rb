require 'rest-client'
require 'json'
require 'pry'



def get_character_movies_from_api(character_name)

  #make the web request

  # response_string = RestClient.get("http://www.swapi.co/api/people/")
  # response_hash = JSON.parse(response_string.body)
  # puts JSON.pretty_generate(response_hash)

  response_string = RestClient.get("https://www.swapi.co/api/people/")
  response_hash = JSON.parse(response_string.body)

  # while response_hash
  #   find_character = response_hash["results"].find do |character_data|
  #     # puts "#{character_data["name"]}     #{character_name}"
  #     if character_name == character_data["name"].downcase
  #     puts character_data["films"]
  #       film = character_data["films"]
  #       return film
  #     end
  #   end
  #
  #   if response_hash = response_hash["next"]
  #     response_hash = JSON.parse(RestClient.get(response_hash).body)
  #   else
  #     nil
  #   end


while response_string
  find_character = response_hash["results"].find do |character_data|
    # puts "#{character_data["name"]}     #{character_name}"
    if character_name == character_data["name"].downcase
    puts character_data["films"]
      film = character_data["films"]
      return film
    end
  end

  if response_string = RestClient.get(response_hash["next"])
    response_hash = JSON.parse(response_string.body)
  else
    nil
  end

  # response_hash = response_hash["next"] ? JSON.parse(RestClient.get(response_hash["next"])) : nil
end

  # while character_hash
  #     film_urls = character_hash["results"].find do |hash|
  #       hash["name"].downcase == character
  #     end
  #     if film_urls
  #       return film_urls["films"].map do |film|
  #         JSON.parse(RestClient.get(film))
  #       end
  #     end
  #     character_hash = character_hash["next"] ? JSON.parse(RestClient.get(character_hash["next"])) : nil
  #   end
  # end


   # puts find_character

#   find_film = find_character.each do |key, value|
#      if key == "films"
#        return value
#      end
# end
# puts find_film
  # response_hash.each do |key, value|
  #
  #   if key == response_hash["results"]['name'] && key == character_name
  #     response_hash["results"]["films"]
  #   end
  # end

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  # films = get_character_movies_from_api(character_name)
  film_url = films.map do |film|
    response_string = RestClient.get(film)
    response_hash = JSON.parse(response_string.body)

    title = response_hash["title"]
    puts title
    # return title
  # title = response_hash["results"].find do |character_data|
  #   # puts "#{character_data["name"]}     #{character_name}"
  #   if character_name == character_data["name"].downcase
  #   puts character_data["films"]
  #     film = character_data["films"]
  #     return film
  #   end
  end

end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
