class TagsController < ApplicationController
  def index
    redirect_to root_path
  end

  def show
    @tag = Tag.find_by_permalink(params[:id])
    redirect_to root_path and return if @tag.nil?
    @updates = @tag.updates.latest(10)
    @goals = @tag.goals
  end

end
