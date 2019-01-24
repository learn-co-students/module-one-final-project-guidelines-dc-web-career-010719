class Recipe < ActiveRecord::Base
  has_many :user_recipes
  has_many :users, through: :user_recipes
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  def add_ingredient(ingredient, amount)
    RecipeIngredient.create(recipe_id: self.id, ingredient_id: ingredient.id, amount: amount)
  end

  def self.recipe_exists?(recipe_name)
    if !self.find_by(name: recipe_name)
      puts "We don't have that recipe, sorry."
      return false
    else
      return true
    end
  end

  def self.most_popular_recipe
    self.find(UserRecipe.group("recipe_id").where("user_recipes.favorite?" => true).count.max_by {|k,v| v }[0])
  end

  def self.five_most_popular_recipes
    top5 = UserRecipe.group("recipe_id").where("user_recipes.favorite?" => true).count.sort_by{|k,v|v}.last(5).reverse
    top5.to_h.keys.map {|id| Recipe.find(id)}
  end

  def self.popular_recipes
    recipes = UserRecipe.group("recipe_id").where("user_recipes.favorite?" => true).count.sort_by{|k,v|v}.reverse
    recipes.to_h.keys.map {|id| Recipe.find(id)}
  end
end
