require_relative '../config/environment'

def exit_program
  puts "Goodbye!  See you again soon.  Or not."
end

puts "Welcome to our yet to be named cocktail recipe database.  Please enter your name:"

name = gets.chomp

User.find_or_create_by(name: name)

puts "Welcome, #{name}!"
puts "Here are the options that we have:"
puts "1. See a list of all recipes by name"
puts "2. Search for a recipe by name"
puts "3. Search for a list of recipes by ingredient"
puts "4. View your favorites list"
puts "5. Edit your favorites list"
puts "6. See a list of the most popular recipes"
puts "7. See a list of the most-used ingredients"
puts "8. Exit the program"

puts "Please enter a number(1-8) to choose an option:"
number = gets.chomp

while number != "8"
  if number == "1"
    list()
    puts "Please enter another number from 1-8:"
    number = gets.chomp
  elsif number == "2"
    find_recipe()
    puts "Please enter another number from 1-8:"
    number = gets.chomp
  elsif number == "3"
    search_by_ingredient()
    puts "Please enter another number from 1-8:"
    number = gets.chomp
  elsif number == "4"
    view_favorites()
    puts "Please enter another number from 1-8:"
    number = gets.chomp
  elsif number == "5"
    edit_favorites()
    puts "Please enter another number from 1-8:"
    number = gets.chomp
  elsif number == "6"
    most_popular_recipes()
    puts "Please enter another number from 1-8:"
    number = gets.chomp
  elsif number == "7"
    most_used_ingredients()
    puts "Please enter another number from 1-8:"
    number = gets.chomp
  else
    "Command not recognized.  Please enter a number from 1-8."
    puts "Please enter another number from 1-8:"
    number = gets.chomp
  end
  exit_program
end




puts "HELLO WORLD"
