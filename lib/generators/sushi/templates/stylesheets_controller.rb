class StylesheetsController < ApplicationController
  def open
    stylesheet = get_stylesheet
    @style = stylesheet.body
  end
  
  def edit
    @stylesheet = get_stylesheet
  end
  
  def update
    @stylesheet = get_stylesheet
    
    if @stylesheet.update_attributes(params[:stylesheet])
      redirect_to(edit_stylesheet_path, :notice => 'Stylesheet was successfully updated.')
    else
      render :action => "edit"
    end
      
  end
  
  private
  
  def get_stylesheet
    Stylesheet.first
  end
end
