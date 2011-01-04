class HomeController < ApplicationController
  def index
    @goals = Goal.most_updated
    @updates = Update.latest(10)
  end

  def feedback
    AdminMailer.delay.notify("Secret Goals Feedback from #{current_user.nil? ? 'anonymous' : current_user.email}",
                         params[:feedback][:message],
                         {:email => params[:feedback][:email], :current_user => current_user})
    render :nothing => true
  end
end
