require_relative "spec_helper"

describe 'User' do

  let (:user) {User.new}
  it "returns true when instantiated" do
    expect(user.is_a?(User)).to be true
  end
  
  it "should have many planners" do 
    planner = User.reflect_on_association(:planners)
    expect(planner.macro).to eq(:has_many)
  end

  it "should have many festivals" do 
    festival = User.reflect_on_association(:festivals)
    expect(festival.macro).to eq(:has_many)
  end

  it "should have festivals through planners" do
    festival = User.reflect_on_association(:festivals)
    expect(festival.macro).to eq(:has_many)
    festival.options[:through].should eq :planners 
  end
end