require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  # response_string = RestClient.get('http://www.swapi.co/api/people/')
  # response_hash = JSON.parse(response_string)


  character_string = RestClient.get("http://www.swapi.co/api/people/?=page1")
  character_hash = JSON.parse(character_string)
  while character_string

    character_hash["results"].each do |character_results|
      if character_results["name"].downcase == character.downcase
        urls = character_results["films"]

        collections = urls.collect do |url|
          JSON.parse(RestClient.get(url))
        end
        return collections

      end
    end

    if character_hash["next"]
      character_string = RestClient.get(character_hash["next"])
      character_hash = JSON.parse(character_string)
    else
      character_string = nil
    end
  end


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
  films.each.with_index do |film, x|
    puts (x + 1).to_s + " " + film["title"]
  end
end


def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
  # binding.pry
end
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
