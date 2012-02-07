class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "p4ss"
    end
    # Only needed if Devise is running
    # warden.custom_failure! if performed?
  end
  
  
end
