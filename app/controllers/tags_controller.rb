class TagsController < ApplicationController
  def index
    redirect_to root_path
  end

  def show
    @tag = Tag.find_by_permalink(params[:id])
    redirect_to root_path and return if @tag.nil?
    @page = (params[:page] || 0).to_i
    @updates = @tag.updates.latest(10, @page)
    @goals = @tag.goals
    @tags = Tag.most_updated
  end

end
