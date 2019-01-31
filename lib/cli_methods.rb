require_relative '../config/environment'
require 'colorize'
require 'colorized_string'

  def welcome_user
    system "clear"
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
    system "clear"
    line
    puts "Hello, #{user.name}! I am QL bot. I take commands from you.".colorize(:light_blue)
    user
  end

  def line
    puts "----------------------------------------------------------".colorize(:blue)
  end

  def stars
    puts "**********************************************************".colorize(:blue)
  end

  def menu_bar
    line
    stars
    line
  end

  def menu(user)
    menu_bar
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
    system "clear"
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
      user.view_favorites_list_as_menu
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
    puts "
                              / /
                 _,  __ __ __/ /____  , _
                (_)_(_)(_)(_/_/_)/ (_/_</_
                 /|                 /
                |/                 '
                ".colorize(:light_blue)
    line
    puts "Goodbye, #{name}! Happy mixing!".colorize(:light_blue)
  end

  def list
    offer_recipes_as_menu("Here's a list of all the recipes we have:".colorize(:light_blue), Recipe.all)
  end

  def return_recipe(choice)
    system "clear"
    line
    # menu(user) if choice == "back to menu"
    puts "Here's the #{choice} recipe:".colorize(:light_blue)
    format_recipe(Recipe.find_by(name: choice))
  end

  def offer_recipes_as_numbered_menu(prompt, recipes)
    rec_list = []
    recipes.each_with_index do |r, i|
      rec_list << "#{i+1}. #{r.name}"
    end
    choice = new_select(prompt, rec_list)
    name = choice.split(". ")[1]
    return_recipe(name)
  end

  def offer_recipes_as_menu(prompt, recipes)
    # m = [recipes.map(&:name), "back to menu"]
    return_recipe(new_select(prompt, recipes.map(&:name)))
  end

  def format_recipe_name(recipe_name)
    recipe_name.split(" ").map(&:capitalize).join(" ")
  end

  def find_recipe
    puts "Please input the recipe name:".colorize(:light_blue)
    name = format_recipe_name(gets.chomp)
    if Recipe.recipe_exists?(name)
      line
      rec = Recipe.where("name like ?", "%#{name}%")
      offer_recipes_as_menu("Here are the recipes containing '#{name}':".colorize(:light_blue), rec)
    end
    rec
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
      puts "   #{ing[0]} -- #{ing[1]}"
    end
    recipe
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

  def chastise_user_for_entering_zero(num, item)
    if num == 0
      puts "Okay, showing you 0 #{item}.......


      There's nothing here.".colorize(:light_blue)
    end
  end

  def most_popular_recipes
    num = prompt_for_list_limit(Recipe.all, "recipes")
    line
    chastise_user_for_entering_zero(num, "recipes")
    return if num == 0
    recs = []
    Recipe.popular_recipes.each_with_index do |r,i|
      break if i == num || num == 0
      recs << r
    end
    offer_recipes_as_numbered_menu("Here are the #{num} most popular recipes:".colorize(:light_blue), recs)
  end

  def most_used_ingredients
    num = prompt_for_list_limit(Ingredient.all, "ingredients")
    line
    chastise_user_for_entering_zero(num, "ingredients")
    return if num == 0
    puts "Here are the #{num} most-used ingredients:".colorize(:light_blue)
    # line
    Ingredient.used_ingredients.each_with_index do |ing, ind|
      break if ind == num
      puts "#{ind+1}. #{ing.name}"
    end
  end

  def new_select(prompt, choices)
    p = TTY::Prompt.new
    p.select(prompt.colorize(:light_blue), choices, per_page: 15)
  end

  def new_multi_select(prompt, choices)
    p = TTY::Prompt.new
    p.multi_select(prompt.colorize(:light_blue), choices, per_page: choices.size)
  end

  # def prompt_user_to_add_favorites(user)
  #   line
  #   system "clear"
  #   if list = find_recipe
  #     line
  #     binding.pry
  #     new_multi_select("Which recipe(s) would you like to add?", list.map{(&:name)}).each do |a|
  #       user.add_to_favorites(Recipe.find_by(name:a)) unless user.favorites.include?(Recipe.find_by(name:a))
  #     end
  #     system "clear"
  #     user.view_favorites_list_as_names
  #   end
  # end

  def prompt_user_to_add_favorites(user)
    line
    system "clear"
    if lists = find_recipe
      line
      new_multi_select("Which recipe(s) would you like to add?", lists.map(&:name)).each do |a|
        user.add_to_favorites(Recipe.find_by(name:a)) unless user.favorites.include?(Recipe.find_by(name:a))
      end
      system "clear"
      user.view_favorites_list_as_names
    end
  end

  def prompt_user_to_remove_favorites(user)
    line
    new_multi_select("Which recipe(s) would you like to remove?", user.list_favorites_names).each do |r|
      user.remove_from_favorites(Recipe.find_by(name:r))
    end
    system "clear"
    user.view_favorites_list_as_names
  end

  def edit_favorites_list(user)
    user.view_favorites_list_as_names
    line
    choice = new_select("Would you like to add to your favorites, or remove something on your list?", ['add', 'remove', 'back to menu'])
    if choice == "add"
      prompt_user_to_add_favorites(user)
    elsif choice == "remove"
      prompt_user_to_remove_favorites(user)
    else
      menu(user)
    end
  end
