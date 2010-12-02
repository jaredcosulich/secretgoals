class Admin::BlueprintsController < ApplicationController
  layout false, :only => [:show]

  def index

  end

  def show
    render :action => params[:id]
  end
end
