class HomeController < ApplicationController
  def index
    @goals = Goal.most_updated
    @updates = Update.latest(10)
    @tags = Tag.most_updated
  end

  def feedback
    AdminMailer.notify("Secret Goals Feedback from #{current_user.nil? ? 'anonymous' : current_user.email}",
                         params[:feedback][:message],
                         {:email => params[:feedback][:email], :current_user => current_user}).deliver
    render :nothing => true
  end
end
