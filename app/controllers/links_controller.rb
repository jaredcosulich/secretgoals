class LinksController < ApplicationController
  def index
    if user = User.find_by_authentication_token(params[:token])
      sign_in(user)
    end
    if link = Link.find_by_id(params[:link])
      link.clicks.create
      redirect_to(link.path_with_additional_params(params))
    else
      redirect_to root_path
    end
  end
end
