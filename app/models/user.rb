class User < ActiveRecord::Base
  has_many :user_recipes
  has_many :recipes, through: :user_recipes

  def add_to_favorites(recipe)
    UserRecipe.create(user_id: self.id, recipe_id: recipe.id, favorite?: true)
  end

  def remove_from_favorites(recipe)
    rec = UserRecipe.find_by(user_id: self.id, recipe_id: recipe.id, favorite?: true)
    rec.toggle!(:favorite?)
  end

  def favorites
    favs = UserRecipe.where({user_id: self.id, favorite?: true})
    favs.map do |fav|
      rec = Recipe.find(fav.recipe_id)
    end
  end

  def view_favorites_list
    puts "Here is your current favorites list:".colorize(:light_blue)
    self.favorites.each do |fav|
      format_recipe(fav)
    end
  end

  def list_favorites_names
    names = self.favorites.map(&:name)
  end
end
