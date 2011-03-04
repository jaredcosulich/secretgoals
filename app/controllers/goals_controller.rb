class GoalsController < ApplicationController
  before_filter :load_goal, :only => [:show, :add]
  before_filter :authenticate_user!, :only => [:new]
  protect_from_forgery :except => :go

  def index
    redirect_to root_path
  end

  def go
    if goal = Goal.find_by_permalink(PermalinkFu.escape(params[:title]))
      redirect_to goal_path(goal)
    else
      @goals = Goal.most_updated
      @goal = Goal.new(:title => params[:title])
      @tags = Tag.most_updated
      render "goals/show"
    end
  end

  def show
    @page = (params[:page] || 0).to_i
    @updates = @goal.updates.latest(10, @page)
    if @updates.empty?
      @goals = Goal.most_updated
    end
    @tags = Tag.most_updated
  end

  protected
  def load_goal
    @goal = Goal.find_by_permalink(params[:id])
    redirect_to root_path if @goal.nil?
  end
end
