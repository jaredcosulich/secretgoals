class MeGoalsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user_goals = current_user.user_goals
  end

  def show
    @user_goal = current_user.user_goals.find(params[:id])
    @goal = @user_goal.goal
  end

  def create
    if goal = Goal.find_by_permalink(params[:goal])
      user_goal = current_user.user_goals.create(:goal => goal)
      redirect_to me_goal_path(user_goal)
    else
      redirect_to me_goals_path
    end
  end
end
