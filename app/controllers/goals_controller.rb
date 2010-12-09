class GoalsController < ApplicationController
  before_filter :load_goal, :only => [:show, :add]
  before_filter :authenticate_user!, :only => [:new]

  def index
    redirect_to root_path
  end

  def new
    @goal = Goal.find_by_title(params[:goal]) || Goal.new(:title => params[:goal])
  end

  def show
    @updates = @goal.updates.latest(10)
    if @updates.empty?
      redirect_to current_user.nil? ? register_path(:goal => @goal.title) : new_goal_path(:goal => @goal.title)
    end
  end

  protected
  def load_goal
    @goal = Goal.find_by_permalink(params[:id])
  end
end
