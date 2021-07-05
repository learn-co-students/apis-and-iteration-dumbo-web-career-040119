def welcome
  puts "Clearly, you're obsessed with Star Wars..."
end

def get_character_from_user
  puts "Who's your favorite character? 🤔"
  puts " "
  gets.chomp.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end
