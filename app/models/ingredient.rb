class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  def self.most_used_ingredient
    self.find(RecipeIngredient.group("ingredient_id").count.max_by {|k,v| v }[0])
  end

  def self.five_most_used_ingredients
    top5 = RecipeIngredient.group("ingredient_id").count.sort_by{|k,v|v}.last(5).reverse
    top5.to_h.keys.map {|id| Ingredient.find(id)}
  end

end
