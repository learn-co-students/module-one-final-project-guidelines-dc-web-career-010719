require_relative 'spec_helper'

context "CLI methods" do

  describe "#format_recipe_name" do
    it "formats the recipe name" do
      expect(format_recipe_name("Gin and Tonic")).to eq("Gin And Tonic")
    end
  end

  describe "#exit_program" do
    it "terminates the running of the program and outputs the goodbye message" do
      expect{exit_program('Hai')}.to output(/Goodbye, Hai! Happy mixing!/).to_stdout
    end
  end

end
