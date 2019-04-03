require 'rest-client'
require 'json'
require 'pry'

def get_characters(url)
  characters_list = RestClient.get(url)
  JSON.parse(characters_list)
end

def list_of_films(character_hash)
  character_hash["films"].collect do |url|
    JSON.parse(RestClient.get(url))
  end
end


def get_character_movies_from_api(character)

  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
while character_hash
    film_urls = character_hash["results"].find do |hash|
      hash["name"].downcase == character
    end
    if film_urls
      return film_urls["films"].map do |film|
        JSON.parse(RestClient.get(film))
      end
    end
    character_hash = character_hash["next"] ? JSON.parse(RestClient.get(character_hash["next"])) : nil
  end
end

def print_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  counter = 1
    puts "Oh, right. Here you can see this fellow:"
  films_hash.each do |film|
    puts " "
    puts "#{counter}. #{film['title']}"
    puts "(dir. #{film['director']}, #{film['release_date'][0..3]})"
    puts " "
    puts "✨ ✨ ✨ ✨ ✨"
    counter += 1 # counter = counter + 1
  end
        puts "May the force be with you!"
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  print_movies(films_hash)
end
