class TagsController < ApplicationController

  def show
    @tag = Tag.find_by_permalink(params[:id])
    @updates = @tag.updates.latest(10)
  end

end
