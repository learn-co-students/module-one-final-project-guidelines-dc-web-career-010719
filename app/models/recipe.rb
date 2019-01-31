class Recipe < ActiveRecord::Base
  has_many :user_recipes
  has_many :users, through: :user_recipes
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  def add_ingredient(ingredient, amount)
    RecipeIngredient.create(recipe_id: self.id, ingredient_id: ingredient.id, amount: amount)
  end

  def self.recipe_exists?(recipe_name)
    if self.where("name like ?", "%#{recipe_name}%").empty? && self.where("name like ?", "%#{recipe_name}%".upcase).empty?
      puts "We don't have a recipe by that name, sorry.".colorize(:red)
      return false
    else
      return true
    end
  end

  def self.popular_recipes
    recipes = UserRecipe.group("recipe_id").where("user_recipes.favorite?" => true).count.sort_by{|k,v|v}.reverse
    recipes.to_h.keys.map {|id| Recipe.find(id)}
  end
end
