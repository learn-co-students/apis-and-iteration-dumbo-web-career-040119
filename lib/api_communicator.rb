require 'pry'
require 'colorize'
require 'rest_client'
require 'json'

#Method definitions are temporary

# puts "Welcome to book searcher!".magenta
puts "What character you looking for?".green
v = gets.chomp

url = "http://www.swapi.co/api/people/"

response = RestClient.get(url)
hashes = JSON.parse response.body

named_hashes = hashes["results"].find do |name|
 #IS NAME KEY EQ TO NAME GIVEN? (IS W/IN ARRAY)
 if v == name["name"]
binding.pry
   name
 end
end


url = "https://www.swapi.co/api/films/"

response = RestClient.get(url)
hashes = JSON.parse response.body

named_hashes.each do |i|
  if i == hashes[]
# named_films = hashes["title"].select do |film|
