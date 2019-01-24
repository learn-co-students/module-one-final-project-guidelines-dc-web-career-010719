require_relative 'spec_helper'
require 'pry'

describe "Recipe" do

  describe "#recipe_exists?" do

    let!(:recipe) { Recipe.create(name:"Gin and Tonic")}

    it "receives a recipe name and returns true if that recipe exists in the database" do
      expect(Recipe.recipe_exists?("Gin and Tonic")).to be true
    end

    it "returns false if that recipe doesn't exist in the database" do
      expect(Recipe.recipe_exists?("Dr. Pepper")).to be false
    end

  end
  
  describe "#most_popular_recipe" do

    let!()


  end

end
