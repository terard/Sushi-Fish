class PageController < ApplicationController
  def show
    page = params[:page] || params[:section]
    @page = Page.find_by_name page

    if !@page
      render :action => params[:page]
    end
  end
end
