class DashboardController < ApplicationController
  before_filter :authenticate

  def show
    render :action => params[:page]
  end
end
