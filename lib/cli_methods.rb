require_relative '../config/environment'

def welcome_screen
  puts "

          __        .  __   /,  _   ,_
        _(_/__(_/__/__(_,__/(__(/__/ (_
         _/
         /)
         `
                    _
                   //  .  __        _,_ ,_
                 _(/__/__(_/__(_/__(_/_/ (_
                         _/
                         /)
                         `


                ()   ()      ()   /
                  ()      ()  () /
                  ______________/___
                  \\            /   /
                   \\^^^^^^^^^^/^^^/
                    \\     ___/   /                     WELCOME
                     \\   (   )  /                        TO THE
                      \\  (___) /                           COCKTAIL
                       \\ /    /                              DATABASE!
                        \\    /
                         \\  /
                          \\/
                          ||
                          ||
                          ||
                          ||
                          ||
                          /\\
                         /;;\\
                    ==============

"
puts "Welcome to Quicker Liquor!  Please enter your name:"
name = gets.chomp
user = User.find_or_create_by(name: name)
puts "Welcome, #{user.name}!"
end

def help_menu
  puts "Here are your options:"
  puts "1. See a list of all recipes by name"
  puts "2. Search for a recipe by name"
  puts "3. Search for a list of recipes by ingredient"
  puts "4. View your favorites list"
  puts "5. Edit your favorites list"
  puts "6. See a list of the most popular recipes"
  puts "7. See a list of the most-used ingredients"
  puts "8. Exit the program"
  puts "Type 'menu' at any time to return to the options menu"
end

def get_number
  puts "Please enter a number(1-8) to choose an option:"
  number = gets.chomp
  run(number)
end

def run(number)
  case number
  when "1"
    puts "You selected 1"
    list()
    get_number
  when "2"
    puts "You selected 2"
    find_recipe()
    get_number
  when "3"
    puts "You selected 3"
    search_by_ingredient()
    get_number
  when "4"
    puts "You selected 4"
    view_favorites()
    get_number
  when "5"
    edit_favorites()
    get_number
  when "6"
    most_popular_recipes
    get_number
  when "7"
    most_used_ingredients
    get_number
  when "menu"
    help_menu
    get_number
  when "8"
    exit_program
  else
    puts "Input not recognized. Type 'menu' to see the options, or enter a number from 1-8"
    get_number
  end
end

def exit_program
  puts "Goodbye!  See you again soon.  Or not."
end
