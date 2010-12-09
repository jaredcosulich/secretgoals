class HomeController < ApplicationController
  def index
    @tags = Tag.in_use.all
    @goals = Goal.all
    @updates = Update.latest(10)
  end

  def feedback
    AdminMailer.notify("Secret Goals Feedback from #{current_user.nil? ? 'anonymous' : current_user.email}",
                         params[:feedback][:message],
                         {:email => params[:feedback][:email], :current_user => current_user}).deliver
    render :nothing => true
  end
end
