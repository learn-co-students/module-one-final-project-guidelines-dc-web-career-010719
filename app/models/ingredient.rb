class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  def self.used_ingredients
    ings = RecipeIngredient.group("ingredient_id").count.sort_by{|k,v|v}.reverse
    ings.to_h.keys.map {|id| Ingredient.find(id)}
  end

end
