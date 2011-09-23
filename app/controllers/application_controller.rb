class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  def user_not_logged_in_redirect
    if !current_user
      redirect_to login_path, :flash => {:error => "Please Login to Continue"}
    end  
  end

  helper_method :current_user
  helper_method :user_not_logged_in_redirect
end
