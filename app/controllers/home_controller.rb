class HomeController < ApplicationController
  def index
    @goals = Goal.most_updated
    @page = (params[:page] || 0).to_i
    @updates = Update.latest(10, @page)
    @tags = Tag.most_updated
  end

  def feedback
    if params[:feedback].blank? || params[:feedback][:message] =~ /\[url=/
      render :nothing => true and return
    end

    AdminMailer.delay.notify("Secret Goals Feedback from #{current_user.nil? ? 'anonymous' : current_user.email}",
                         params[:feedback][:message],
                         {:email => params[:feedback][:email], :current_user => current_user})
    render :nothing => true
  end
end
