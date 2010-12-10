require 'spec_helper'

describe Goal do
  describe "permalinking" do
    it "should create a permalink" do
      goal = Goal.create!(:title => "New Goal")
      goal.permalink.should be_present
    end

    it "should handle .s in the name" do
      Goal.create!(:title => "Climb Mt. Everest")
    end

    it "should handle similar goals" do
      Goal.create!(:title => "New\tGoal")
      Goal.create!(:title => "New Goal")
    end

    it "should handle unicode" do
      Goal.create!(:title => "be 安靜").permalink.should == "be-an-jing"
    end
  end
end
