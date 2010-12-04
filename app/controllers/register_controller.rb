class RegisterController < ApplicationController

  def index
  end

  def create
    user = User.new(params[:register][:user])
    if user.save
      sign_in(:user, user)
      goal = user.goals.create(params[:register][:goal])
    else
      flash[:notice] = user.errors
      render :action => "index"
      return
    end

    redirect_to me_goal_path(goal)
  end
end
