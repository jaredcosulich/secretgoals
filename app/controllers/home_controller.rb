class HomeController < ApplicationController
  def index
    @tags = Tag.all
    @goals = Goal.all
    @updates = Update.latest(20)
  end

end
