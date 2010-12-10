class MeGoalsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_user_goal, :only => [:show, :add_update]

  def index
    redirect_to (user_goals = current_user.user_goals).empty? ? root_path : me_goal_path(user_goals.first)
  end

  def show
    @goal = @user_goal.goal
  end

  def add_update
    @user_goal.updates.create(params[:update])
    redirect_to me_goal_path(@user_goal)
  end

  def create
    redirect_to :back and return unless params[:goal].present? && params[:goal][:title].present?

    goal = Goal.find_or_create_by_title(params[:goal][:title])
    user_goal = current_user.user_goals.create(:goal => goal)
    redirect_to me_goal_path(user_goal)
  end

  protected
  def load_user_goal
    @user_goal = current_user.user_goals.find(Integer.unobfuscate(params[:id]))
  end
end
