class UpdatesController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    if @update = Update.find_by_id(Integer.unobfuscate(params[:id]))
      @goal = @update.goal
    else
      redirect_to root_path
    end
  end
end
