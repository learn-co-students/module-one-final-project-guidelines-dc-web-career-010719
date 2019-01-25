require_relative "spec_helper"

describe 'Festival' do

  let (:festival) {Festival.new}
  it "returns true when instantiated" do
    expect(festival.is_a?(Festival)).to be true
  end
  
  it "should have many users" do 
    user = Festival.reflect_on_association(:users)
    expect(user.macro).to eq(:has_many)
  end

  it "should have many planners" do 
    planner = Festival.reflect_on_association(:planners)
    expect(planner.macro).to eq(:has_many)
  end

  it "should have users through planners" do
    user = Festival.reflect_on_association(:users)
    expect(user.macro).to eq(:has_many)
    user.options[:through].should eq :planners 
  end
end