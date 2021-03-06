require 'spec_helper'

describe "Auto Login Links" do
  before :each do
    @user = User.first
    @emailing = Emailing.create!(:user => @user, :email_name => "ignored")
    @auto_login_url = @emailing.auto_login_url(me_goal_path(@user.user_goals.first))
  end


  it "should login the user and redirect to the link path" do
    visit @auto_login_url

    current_url.should == "http://test.secretgoals.com/me/goals/#{@user.user_goals.first.to_param}"
    controller.current_user.should == @user
  end

  it "should prompt for login if bad token" do
    visit @auto_login_url + "XXXX"

    controller.current_user.should be_nil
    current_url.should == "http://test.secretgoals.com/users/login"
  end

  it "should pass along additional params" do
    visit @auto_login_url + "?x=y"

    controller.current_user.should == @user
    current_url.should == "http://test.secretgoals.com/me/goals/#{@user.user_goals.first.to_param}?x=y"
  end

end
