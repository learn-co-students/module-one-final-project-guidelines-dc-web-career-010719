class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  def self.most_used_ingredient
    self.find(RecipeIngredient.group("ingredient_id").count.max_by {|k,v| v }[0])
  end

end
