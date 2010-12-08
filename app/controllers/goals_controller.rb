class GoalsController < ApplicationController
  def index
    redirect_to root_path
  end

  def show
    @goal = Goal.find_by_permalink(params[:id])
    @updates = @goal.updates.latest(10)
  end

end
