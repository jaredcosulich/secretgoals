class GoalsController < ApplicationController

  def show
    @goal = current_user.goals.find(params[:id])  
  end

end
