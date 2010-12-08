class GoalsController < ApplicationController

  def show
    @tag = Tag.where("permalink=?", params[:id]).first
    @updates = @tag.latest_updates.limit(10)
  end

end
