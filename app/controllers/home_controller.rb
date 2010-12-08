class HomeController < ApplicationController
  def index
    @tags = Tag.in_use.all
    @goals = Goal.all
    @updates = Update.latest(20)
  end

end
