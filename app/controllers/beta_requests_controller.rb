class BetaRequestsController < ApplicationController
  def create
    if params[:beta_request] && params[:beta_request][:email].present?
      BetaRequest.create(params[:beta_request])
      flash[:notice] = "Thanks for your interest. We'll let you know as soon as we launch."
    else
      flash[:notice] = "Please provide your email if you'd like more information."
    end

    redirect_to root_path    
  end
end
