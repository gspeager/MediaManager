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
      DataAccess.createUserDirectories(@user.public_token)
      redirect_to edit_path, :flash => {:success => "Signed Up! Please enter some details about yourself."}
    else
      render "new", :flash => {:error => "Unable to Sign Up, Please Try Again."}
    end
  end

  def view
    @user = User.find_by_public_token(params[:id])
  end

  def home
    @user = current_user
  end
  
  def edit
    @user = current_user
  end

    def update
      @user = current_user
      if @user.update_attributes(params[:user])
        redirect_to edit_path, :flash => {:success => "Properties were successfully updated."}
      else
        redirect_to edit_path, :flash => {:error => :unprocessable_entity }
      end
    end  

end
