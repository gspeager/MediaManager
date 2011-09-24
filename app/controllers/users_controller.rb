class UsersController < ApplicationController
  force_ssl
  
  before_filter :user_already_logged_in_redirect, :only => [:new]
  before_filter :user_not_logged_in_redirect, :except => [:new, :create]

  def new
    @user = User.new
    render :layout => 'application_no_sidebar'
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to home_path, :flash => {:success => "Signed Up!"}
    else
      render "new", :flash => {:error => "Unable to Sign Up, Please Try Again."}
    end
  end

  def home
    @user = current_user
  end
  
  def edit
    @user = current_user
  end

end
