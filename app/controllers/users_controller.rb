class UsersController < ApplicationController
  force_ssl
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url, :flash => {:success => "Signed Up!"}
    else
      render "new"
    end
  end
end
