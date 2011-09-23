class SessionsController < ApplicationController
  force_ssl

  def new
  end

  def create
  	user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to home_path, :flash => {:info => "Logged in!"}
    else
      flash.now[:error] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, :flash => {:success => "Logged out!"}
  end
end
