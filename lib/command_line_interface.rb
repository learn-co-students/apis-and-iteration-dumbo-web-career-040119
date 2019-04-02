def welcome
  puts "Welcome to Star Wars Database"
end

def get_character_from_user
  puts "Please enter a character name"
  # use gets to capture the user's input. This method should return that input, downcased.
  input = gets.chomp.downcase
end
