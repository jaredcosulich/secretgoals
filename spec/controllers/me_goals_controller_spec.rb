require 'spec_helper'

describe MeGoalsController do
  describe "show" do
    before :each do
      @user = Factory(:user_goal).user
      sign_in @user
    end
    it "should redirect to index if goal can't be found" do
      get :show, :id => "bad_id"
      response.should redirect_to me_goals_path
    end

    it "should redirect to index if goal can't be found" do
      other_user_goal = Factory(:user_goal)
      get :show, :id => other_user_goal.id.to_obfuscated
      response.should redirect_to me_goals_path
    end
  end
end
