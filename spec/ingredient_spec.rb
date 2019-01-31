require_relative 'spec_helper'

describe "Ingredient" do

  describe "#used_ingredients" do

    let!(:recipe1) {Recipe.create(name:"Gin and Tonic")}
    let!(:ingredient1) {Ingredient.create(name:"Gin")}
    let!(:ingredient2) {Ingredient.create(name:"Tonic water")}
    let!(:recipe2) {Recipe.create(name:"Gin Smash")}
    let!(:ingredient3) {Ingredient.create(name:"Sugar")}
    let!(:ing_rec1) {recipe1.add_ingredient(ingredient1, "2 ounces")}
    let!(:ing_rec2) {recipe1.add_ingredient(ingredient2, "5 ounces")}
    let!(:ing_rec3) {recipe2.add_ingredient(ingredient1, "3 ounces")}
    let!(:ing_rec4) {recipe2.add_ingredient(ingredient3, "1 tsp")}

    it "returns an array of ingredient objects" do
      expect(Ingredient.used_ingredients[2]).to be_kind_of(Ingredient)
    end

    it "sorts ingredients from most used to least used" do
      expect(Ingredient.used_ingredients[0]).to eq(ingredient1)
    end

  end

end
