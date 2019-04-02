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

def get_character_movies_from_api(character_name)
  counter = 1
  characters = get_characters("http://www.swapi.co/api/people/?page=#{counter}")
  while characters["next"]
   characters["results"].each do |character_hash|
     if character_hash["name"].downcase == character_name
       return list_of_films(character_hash)
  else characters = nil
  end
end
     counter += 1
end
end

def print_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  counter = 1
  films_hash.each do |film|
    puts "#{counter}. #{film['title']}"
    puts film['director']
    puts "----"
    counter += 1 # counter = counter + 1
  end
        puts "May the force be with you!"
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  print_movies(films_hash)
end
