class RegisterController < ApplicationController


  def show
    @user = User.new
  end

  def create
    @user = User.new(params[:register][:user])

    if @user.save
      sign_in(:user, @user)
      if params[:register] && params[:register][:goal] && params[:register][:goal][:title].present?
        user_goal = @user.user_goals.create(:goal => Goal.find_or_create_by_title(params[:register][:goal][:title]))
        redirect_to me_goal_path(user_goal)
      else
        redirect_to root_path
      end
    else
      render :action => :show
    end
  end
end
