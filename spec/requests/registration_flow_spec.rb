require 'spec_helper'

describe "Registration Flow" do
  it "should allow you to register and assign you a fake password" do
    visit "/register"

    fill_in "What is your goal?", :with => "rock"
    select "2 weeks", :from => "How often should we check in on your progress?"
    fill_in "How should we check on your progress?", :with => "test@example.com"

    click_button "Get Started"

    user = User.last
    user.email.should == "test@example.com"
    user.encrypted_password.should_not be_blank
    user.goals.first.title.should == "rock"
    user.user_goals.first.notification_delay.should == 14
  end

  it "should allow you to opt out of check-in" do
    visit "/register"

    fill_in "What is your goal?", :with => "rock"
    select "never", :from => "How often should we check in on your progress?"
    fill_in "How should we check on your progress?", :with => "test@example.com"

    click_button "Get Started"

    user = User.last
    user.email.should == "test@example.com"
    user.encrypted_password.should_not be_blank
    user.goals.first.title.should == "rock"
    user.user_goals.first.notification_delay.should == nil
  end
end
