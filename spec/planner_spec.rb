require_relative "spec_helper"

describe Planner do
  it "should belong to a user" do
    Planner.new.should be_valid
  end

  let (:planner) {Planner.new}
  it "returns true when instantiated" do
    expect(planner.is_a?(Planner)).to be true
  end

  it "belongs to a user" do
    planner = Planner.new
    user = User.new
    user.planners << planner
    expect(planner.user).to be user
  end

  it "belongs to a festival" do
    planner = Planner.new
    festival = Festival.new
    festival.planners << planner
    expect(planner.festival).to be festival
  end
end







