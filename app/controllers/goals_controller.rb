class GoalsController < ApplicationController
  before_filter :load_goal, :only => [:show, :add]
  before_filter :authenticate_user!, :only => [:new]

  def index
    redirect_to root_path
  end

  def new
    @goal = Goal.find_by_title(params[:goal]) || Goal.new(:title => params[:goal])
  end

  def go
    if goal = Goal.find_by_title(params[:title])
      redirect_to goal_path(goal)
    else
      @goals = Goal.most_updated
      @goal = Goal.new(:title => params[:title])
      render "goals/show"
    end
  end

  def show
    @updates = @goal.updates.latest(10)
    if @updates.empty?
      @goals = Goal.most_updated
    end
  end

  protected
  def load_goal
    @goal = Goal.find_by_permalink!(params[:id])
  end
end
