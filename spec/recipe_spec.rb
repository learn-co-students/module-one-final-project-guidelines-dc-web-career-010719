require_relative 'spec_helper'
require 'pry'

describe "Recipe" do

  describe "#recipe_exists?" do

    let!(:recipe) {Recipe.create(name:"Gin and Tonic")}

    it "receives a recipe name and returns true if that recipe exists in the database" do
      expect(Recipe.recipe_exists?("Gin and Tonic")).to be true
    end

    it "returns false if that recipe doesn't exist in the database" do
      expect(Recipe.recipe_exists?("Dr. Pepper")).to be false
    end

  end

  describe "#add_ingredient" do

    let!(:recipe) {Recipe.create(name:"Gin and Tonic")}
    let!(:ingredient) {Ingredient.create(name:"Gin")}
    let!(:ing_rec) {recipe.add_ingredient(ingredient, "2 ounces")}

    it "creates a new instance in the RecipeIngredient table" do
      expect(RecipeIngredient.all).not_to be_empty
    end

    it "adds the recipe's id into the RecipeIngredient table" do
      expect(RecipeIngredient.find(1).recipe_id).to be recipe.id
    end

    it "adds the ingredient's id into the RecipeIngredient table" do
      expect(RecipeIngredient.find(1).ingredient_id).to be ingredient.id
    end

    it "adds the amount of ingredient into the RecipeIngredient table" do
      expect(RecipeIngredient.find(1).amount).to eq("2 ounces")
    end

  end


end
