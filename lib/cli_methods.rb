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
    puts "Welcome to Quicker Liquor! Please enter your name:".colorize(:light_blue)
    name = gets.chomp.capitalize
    user = User.find_or_create_by(name: name)
    line
    puts "Hello, #{user.name}! I am QL bot. I take commands from you.".colorize(:light_blue)
    user
  end

  def line
    puts "-----------------------------".colorize(:blue)
  end

  def menu(user)
    line
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
    choice = new_select("Please choose one:", menu_items)
    run(user, choice)
  end

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
      user.view_favorites_list
      menu(user)
    when 5
      edit_favorites_list(user)
      menu(user)
    when 6
      most_popular_recipes
      menu(user)
    when 7
      most_used_ingredients
      menu(user)
    when 8
      exit_program(user.name)
    end
  end

  def exit_program(name)
    line
    puts "Goodbye, #{name}! See you again soon. Or not.".colorize(:light_blue)
  end

  def list
    puts "Here's a list of all the recipes we have:".colorize(:light_blue)
    line
    Recipe.all.each_with_index do |rec, index|
      puts "#{index+1}. #{rec.name}"
    end
  end

  def format_recipe_name(recipe_name)
    recipe_name.split(" ").map(&:capitalize).join(" ")
  end

  def find_recipe
    puts "Please input the recipe name:".colorize(:light_blue)
    name = format_recipe_name(gets.chomp)
    if Recipe.recipe_exists?(name)
      line
      puts "Here are the recipes containing '#{name}':".colorize(:light_blue)
      rec = Recipe.where("name like ?", "%#{name}%")
      rec.each {|r| format_recipe(r)}
    end
  end

  def search_by_ingredient
    puts "Please input the ingredient name:".colorize(:light_blue)
    name = gets.chomp.split(" ").map(&:capitalize).join(" ")
    line
    if Ingredient.where("name like ?", "%#{name}%").empty?
      puts "We don't have any recipes with that ingredient.".colorize(:red)
    else
      ings = Ingredient.where("name like ?", "%#{name}%")
      ings.each do |ing|
        ris = RecipeIngredient.select(:recipe_id).where("ingredient_id = ?", ing.id)
        recs = ris.map do |ri|
          Recipe.find(ri.recipe_id).name
        end
        puts "Here are the recipes with '#{ing.name}':".colorize(:light_blue)
        recs.each_with_index do |rec_name, index|
          puts "  #{index+1}. #{rec_name}"
        end
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
      if ing[1] == "" || ing[1] == "\n"
        ing[1] = "unspecified"
      end
      puts "   #{ing[0].capitalize} -- #{ing[1]}"
    end
  end

  def prompt_for_list_limit(class_array, item)
    line
    puts "How many of the top #{item} would you like to see? (Please enter a number from 1 to #{class_array.size})".colorize(:light_blue)
    num = gets.chomp.to_i
    until num <= class_array.size
      puts "Sorry, that's more #{item} than we have in our database!  Can you choose a smaller number please?".colorize(:red)
      num = gets.chomp.to_i
    end
    num
  end

  def most_popular_recipes
    num = prompt_for_list_limit(Recipe.all, "recipes")
    Recipe.popular_recipes.each_with_index do |r,i|
      line
      puts "The number #{i+1} most popular recipe is:".colorize(:light_blue)
      format_recipe(r)
      break if i == num - 1
    end
  end

  def most_used_ingredients
    num = prompt_for_list_limit(Ingredient.all, "ingredients")
    line
    puts "Here are the #{num} most-used ingredients:".colorize(:light_blue)
    line
    Ingredient.used_ingredients.each_with_index do |ing, ind|
      puts "#{ind+1}. #{ing.name}"
      break if ind == num - 1
    end
  end

  def new_select(prompt, choices)
    p = TTY::Prompt.new
    p.select(prompt.colorize(:light_blue), choices)
  end

  def new_multi_select(prompt, choices)
    p = TTY::Prompt.new
    p.multi_select(prompt.colorize(:light_blue), choices)
  end

  def prompt_user_to_add_favorites(user)
    line
    if list = find_recipe
      new_multi_select("Which recipe(s) would you like to add?", list.map(&:name)).each do |a|
        user.add_to_favorites(Recipe.find_by(name:a)) unless user.favorites.include?(Recipe.find_by(name:a))
        user.view_favorites_list
      end
    end
  end

  def prompt_user_to_remove_favorites(user)
    line
    new_multi_select("Which recipe(s) would you like to remove?", user.list_favorites_names).each do |r|
      user.remove_from_favorites(Recipe.find_by(name:r))
      user.view_favorites_list
    end
  end

  def edit_favorites_list(user)
    user.view_favorites_list
    line
    choice = new_select("Would you like to add to your favorites, or remove something on your list?", ['add', 'remove'])
    if choice == "add"
      prompt_user_to_add_favorites(user)
    else
      prompt_user_to_remove_favorites(user)
    end

  end
