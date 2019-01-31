require_relative 'spec_helper'

describe "User" do

  before do
    suppress_log_output
  end

  let!(:user) {User.create(name:"Melanie")}
  let!(:recipe1) {Recipe.create(name:"Gin and Tonic")}
  let!(:recipe2) {Recipe.create(name:"Vodka Martini")}
  let!(:user_rec1) {user.add_to_favorites(recipe1)}
  let!(:user_rec2) {user.add_to_favorites(recipe2)}

  describe "#add_to_favorites" do

    it "creates a new instance of UserRecipe" do
      expect(user_rec1).to be_kind_of(UserRecipe)
    end

    it "associates the user with a recipe" do
      expect(user.recipes).to include(recipe1)
    end

    it "sets the UserRecipe favorite status to true" do
      expect(user_rec1.favorite?).to eq(true)
    end

  end

  describe "#remove_from_favorites" do

    it "changes the UserRecipe favorite status to false" do
      expect(user.remove_from_favorites(recipe1).favorite?).to eq(false)
    end

    it "doesn't delete a row from UserRecipe" do
      user.remove_from_favorites(recipe2)
      expect(user.recipes).to include(recipe2)
    end

  end

  describe "#favorites" do

    it "returns an array of all UserRecipes where favorite? = true" do
      expect(user.favorites).to eq([recipe1, recipe2])
    end

    it "does not return UserRecipes where favorite? = false" do
      user.remove_from_favorites(recipe2)
      expect(user.favorites).not_to include(recipe2)
    end

  end

  describe "#view_favorites_list" do

    it "returns an array of the user's favorite recipes" do
      expect(user.view_favorites_list).to eq(user.favorites)
    end

    # it "outputs the user's favorite recipes using the format recipe method" do
    #   expect(user).to receive(format_recipe).with(recipe1)
    #   user.view_favorites_list
    # end

  end

  describe "#list_favorites_names" do

    it "returns an array of the names of a user's favorited recipes" do
      expect(user.list_favorites_names).to include("Gin and Tonic")
    end

  end

end
