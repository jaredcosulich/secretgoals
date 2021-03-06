class UpdatesController < ApplicationController
  before_filter :load_update, :except => :index

  def index
    redirect_to root_path
  end

  def show
    @goal = @update.goal
    @updates = [@update]
  end

  def add_reply
    @update.replies.create(params[:reply].merge(:commenter => current_user))
    redirect_to request.headers["Referer"] + "#update_#{@update.to_param}"
  end

  private
  def load_update
    if (@update = Update.find_by_id(Integer.unobfuscate(params[:id]))).nil?
      redirect_to root_path
    end
  end
end
