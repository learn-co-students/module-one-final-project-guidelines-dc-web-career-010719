require_relative '../config/environment'

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
    name = gets.chomp.capitalize
    user = User.find_or_create_by(name: name)
    line
    puts "Hello, #{user.name}! I am QL bot. I take commands from you."
    user
  end

  def line
    puts "-----------------------------"
  end

  def help_menu
    line
    puts "Here are your options:"
    puts "1. See a list of all recipes by name"
    puts "2. Search for a recipe by name"
    puts "3. Search for a list of recipes by ingredient"
    puts "4. View your favorites list"
    puts "5. Edit your favorites list"
    puts "6. See a list of the most popular recipes"
    puts "7. See a list of the most-used ingredients"
    puts "8. Exit the program"
    puts ""
    puts "Type 'menu' at any time to return to the options menu!"
  end

  def get_number(user)
    line
    puts "Please enter a number(1-8) to choose an option, or enter menu to see the option menu:"
    number = gets.chomp
    run(user, number)
  end

  def run(user, number)
    case number
    when "1"
      puts "You selected option 1. Here is the list of all recipes:"
      list
      get_number(user)
    when "2"
      puts "You selected option 2."
      find_recipe
      get_number(user)
    when "3"
      puts "You selected option 3."
      search_by_ingredient
      get_number(user)
    when "4"
      puts "You selected option 4."
      user.view_your_favorites_list
      get_number(user)
    when "5"
      puts "You selected option 5."
      edit_favorites_list(user)
      get_number(user)
    when "6"
      puts "You selected option 6."
      most_popular_recipes
      get_number(user)
    when "7"
      puts "You selected option 7."
      most_used_ingredients
      get_number(user)
    when "menu"
      help_menu
      get_number(user)
    when "8"
      exit_program
    else
      puts "Input not recognized. Type 'menu' to see the options, or enter a number from 1-8"
      get_number(user)
    end
  end

  def exit_program
    puts "Goodbye! See you again soon. Or not."
  end

  def list
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
    puts "* Instruction: #{recipe.instruction}"
    recipe_ings = RecipeIngredient.where("recipe_id = ?", recipe.id)
    ams = recipe_ings.map(&:amount)
    ings = recipe.ingredients.map(&:name)
    array = ings.zip(ams)
    puts "* List of ingredients:"
    array.each do |ing|
      if ing[1] == ""
        ing[1] = "to taste"
      end
      puts "   #{ing[0].capitalize} -- #{ing[1]}"
    end
  end

  def most_popular_recipes
    Recipe.five_most_popular_recipes.each_with_index do |r,i|
      line
      puts "The number #{i+1} recipe is:"
      format_recipe(r)
    end
  end

  def most_used_ingredients
    line
    puts "Here are the five most-used ingredients among the drinks in our database:"
    line
    Ingredient.five_most_used_ingredients.each_with_index do |ing, ind|
      puts "#{ind+1}. #{ing.name.capitalize}"
    end
  end

  def edit_favorites_list(user)
    line
    user.view_your_favorites_list
    line
    puts "Enter 'add' to add to your favorites list, or 'remove' to remove something you've already favorited."
    input = gets.chomp.downcase
    if input == "add"
      line
      puts "Please enter the name of the recipe you'd like to favorite:"
      recipe = format_recipe_name(gets.chomp)
      if Recipe.recipe_exists?(recipe)
        user.add_to_favorites(Recipe.find_by(name:recipe))
        line
        user.view_your_favorites_list
      end
    elsif input == "remove"
      line
      puts "Please enter the name of the recipe you'd like to remove:"
      recipe = format_recipe_name(gets.chomp)
      if Recipe.recipe_exists?(recipe)
        user.remove_from_favorites(Recipe.find_by(name:recipe))
        line
        user.view_your_favorites_list
      end
    else
      "Sorry, I don't recognize that command."
    end
  end
