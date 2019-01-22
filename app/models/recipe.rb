class Recipe < ActiveRecord::Base
  has_many :user_recipes
  has_many :users, through: :user_recipes
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  def add_ingredient(ingredient, amount)
    RecipeIngredient.create(recipe_id: self.id, ingredient_id: ingredient.id, amount: amount)
  end

  def self.most_popular_recipe
    self.find(UserRecipe.group("recipe_id").where("user_recipes.favorite?" => true).count.max_by {|k,v| v }[0])
  end

end
