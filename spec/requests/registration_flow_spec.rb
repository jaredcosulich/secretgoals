require 'spec_helper'

describe "Registration Flow" do
  it "should allow you to register and assign you a fake password" do
    visit "/register"

    fill_in "What is your goal?", :with => "rock"
    fill_in "How often should we check in on your progress?", :with => "14"
    fill_in "How should we check on your progress?", :with => "test@example.com"

    click_button "Get Started"

    user = User.last
    user.email.should == "test@example.com"
    user.encrypted_password.should_not be_blank
    user.goals.first.title.should == "rock"
    user.user_goals.first.notification_delay.should == 14
  end
end

