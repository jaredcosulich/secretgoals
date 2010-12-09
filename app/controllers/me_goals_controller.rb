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
    redirect_to :back and return unless params[:goal].present? && params[:goal][:title].present?

    goal = Goal.find_or_create_by_title(params[:goal][:title])
    user_goal = current_user.user_goals.create(:goal => goal)
    redirect_to me_goal_path(user_goal)
  end
end
