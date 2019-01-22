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

end
