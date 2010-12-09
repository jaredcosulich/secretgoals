class GoalsController < ApplicationController
  before_filter :load_goal, :only => [:show, :add]

  def index
    redirect_to root_path
  end

  def show
    @updates = @goal.updates.latest(10)
    if @updates.empty? && current_user.nil?
      redirect_to register_path(:goal => @goal.title)
    end
  end

  protected
  def load_goal
    @goal = Goal.find_by_permalink(params[:id])
  end
end
