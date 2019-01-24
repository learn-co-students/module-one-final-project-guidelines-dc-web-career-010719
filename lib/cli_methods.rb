require_relative '../config/environment'
require 'colorize'
require 'colorized_string'

  def welcome_user
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
                           `".colorize(:light_blue)

    puts "
                  ()   ()      ()   /
                    ()      ()  () /
                    ______________/___
                    \\            /   /
                     \\^^^^^^^^^^/^^^/
                      \\     ___/   /                     WELCOME
                       \\   (   )  /                        TO OUR
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
    puts "Welcome to Quicker Liquor! Please enter your name:"
    name = gets.chomp.capitalize
    user = User.find_or_create_by(name: name)
    line
    puts "Hello, #{user.name}! I am QL bot. I take commands from you.".colorize(:blue)
    user
  end

  def line
    puts "-----------------------------"
  end

  # def help_menu
  #   line
  #   puts "Here are your options:"
  #   puts ""
  #   puts "1. See a list of all recipes by name"
  #   puts "2. Search for a recipe by name"
  #   puts "3. Search for a list of recipes by ingredient"
  #   puts "4. View your favorites list"
  #   puts "5. Edit your favorites list"
  #   puts "6. See a list of the most popular recipes"
  #   puts "7. See a list of the most-used ingredients"
  #   puts "8. Exit the program"
  #   puts ""
  #   puts "Type 'menu' at any time to return to the options menu!"
  # end

  def menu(user)
    line
<<<<<<< HEAD
    puts "Please choose one:".colorize(:blue)
    menu_items = {
      "See a list of all recipes by name" => 1,
      "Search for a recipe by name" => 2,
      "Search for a list of recipes by ingredient" => 3,
      "View your favorites list" => 4,
      "Edit your favorites list" => 5,
      "See a list of the most popular recipes" => 6,
      "See a list of the most-used ingredients" => 7,
      "Exit the program" => 8
    }
    choice = new_select("", menu_items)
    run(user, choice)
=======
    puts "Please enter a number(1-8) to choose an option, or enter menu to see the options menu:"
    number = gets.chomp
    run(user, number)
>>>>>>> 547bfd867bd16c77f630f4ec2a8c38a0d856b809
  end

  # def get_number(user)
  #   line
  #   puts "Please enter a number(1-8) to choose an option, or enter menu to see the option menu:".colorize(:blue)
  #   number = gets.chomp
  #   run(user, number)
  # end

  def run(user, choice)
    case choice
    when 1
      line
      list
      menu(user)
    when 2
      line
      find_recipe
      menu(user)
    when 3
      line
      search_by_ingredient
      menu(user)
    when 4
      line
      user.view_favorites_list
      menu(user)
    when 5
      line
      edit_favorites_list(user)
      menu(user)
    when 6
      most_popular_recipes
      menu(user)
    when 7
      line
      most_used_ingredients
      menu(user)
    # when "menu"
    #   # help_menu
    #   menu
    #   get_number(user)
    when 8
      exit_program(user.name)
    # else
    #   puts "Input not recognized. Type 'menu' to see the options, or enter a number from 1-8"
    #   get_number(user)
    end
  end

  def exit_program(name)
    puts "Goodbye, #{name}! See you again soon. Or not."
  end

  def list
    puts "Here's a list of all the recipes we have:"
    Recipe.all.each_with_index do |rec, index|
      puts "#{index+1}. #{rec.name}"
    end
  end

  def format_recipe_name(recipe_name)
    recipe_name.split(" ").map(&:capitalize).join(" ")
  end

  def find_recipe
    puts "Please input the recipe name:"
    name = format_recipe_name(gets.chomp)
    if Recipe.recipe_exists?(name)
      rec = Recipe.find_by(name: name)
      format_recipe(rec)
    end
  end

  def search_by_ingredient
    puts "Please input the ingredient name:"
    name = gets.chomp.split(" ").map(&:downcase).join(" ")
    if !Ingredient.find_by(name: name)
      puts "We don't have that ingredient."
    else
      ing = Ingredient.find_by(name: name)
      recipe_ings = RecipeIngredient.select(:recipe_id).where("ingredient_id = ?", ing.id)
      reps = recipe_ings.map { |ri| Recipe.find(ri.recipe_id).name }
      puts "Here is the list of recipes having #{name}:"
      reps.each_with_index do |rep_name, index|
        puts "  #{index+1}. #{rep_name}"
      end
    end
  end

  def format_recipe(recipe)
    line
    puts "* Recipe: #{recipe.name}"
    puts "* Instructions: #{recipe.instruction}"
    recipe_ings = RecipeIngredient.where("recipe_id = ?", recipe.id)
    ams = recipe_ings.map(&:amount)
    ings = recipe.ingredients.map(&:name)
    array = ings.zip(ams)
    puts "* List of ingredients:"
    array.each do |ing|
      if ing[1] == ""
        ing[1] = "unspecified"
      end
      puts "   #{ing[0].capitalize} -- #{ing[1]}"
    end
  end

  # def most_popular_recipes
  #   Recipe.five_most_popular_recipes.each_with_index do |r,i|
  #     line
  #     puts "The number #{i+1} recipe is:".colorize(:light_blue)
  #     format_recipe(r)
  #   end
  # end

  def most_popular_recipes
<<<<<<< HEAD
    puts "How many of our top recipes would you like to see? (Please enter a number.)".colorize(:light_blue)
    num = gets.chomp.to_i
    until num <= Recipe.all.size
      puts "Sorry, that's more recipes than we have in our database!  Can you choose a smaller number please?"
      num = gets.chomp.to_i
    end
    Recipe.popular_recipes.each_with_index do |r,i|
=======
    line
    puts "Here are the five most popular recipes in our database:"
    Recipe.five_most_popular_recipes.each_with_index do |r,i|
>>>>>>> 547bfd867bd16c77f630f4ec2a8c38a0d856b809
      line
      puts "The number #{i+1} most popular recipe is:".colorize(:light_blue)
      format_recipe(r)
      break if i == num - 1
    end
  end

  def most_used_ingredients
    puts "Here are the five most-used ingredients among the drinks in our database:"
    line
    Ingredient.five_most_used_ingredients.each_with_index do |ing, ind|
      puts "#{ind+1}. #{ing.name.capitalize}"
    end
  end

  def new_select(prompt, choices)
    p = TTY::Prompt.new
    p.select(prompt, choices)
  end

  def new_multi_select(prompt, choices)
    p = TTY::Prompt.new
    p.multi_select(prompt, choices)
  end

  def edit_favorites_list(user)
    line
    user.view_favorites_list
    line
    # puts "Enter 'add' to add to your favorites list, or 'remove' to remove something you've already favorited."
    # input = gets.chomp.downcase
    choice = new_select("Would you like to add to your favorites, or remove something on your list?".colorize(:light_blue), ['add', 'remove'])
    if choice == "add"
      line
      puts "Please enter the name of the recipe you'd like to favorite:".colorize(:light_blue)
      recipe = format_recipe_name(gets.chomp)
      if Recipe.recipe_exists?(recipe)
        user.add_to_favorites(Recipe.find_by(name:recipe))
        line
        user.view_favorites_list
      end
    elsif choice == "remove"
      line
      prompt = TTY::Prompt.new
      choices = user.list_favorites_names
      removals = prompt.multi_select("Which recipe(s) would you like to remove?".colorize(:light_blue), choices)
      # puts "Please enter the name of the recipe you'd like to remove:"
      # recipe = format_recipe_name(gets.chomp)
      removals.each do |removal|
        if Recipe.recipe_exists?(removal)
          user.remove_from_favorites(Recipe.find_by(name:removal))
          line
          user.view_favorites_list
        end
      end
    else
      puts "Sorry, I don't recognize that command."
    end
  end
