require 'spec_helper'

describe GoalsController do

  describe "show" do
    it "should redirect home if the goal does not exist" do
      get :show, :id => "not-a-real-goal"
      response.should redirect_to(root_path)
    end

  end

end
