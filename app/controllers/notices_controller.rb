class NoticesController < ApplicationController
  def create
  	@user = User.find(params[:user_id])
  	@status = @user.notices.create(params[:notice])
  	@status.author_id = current_user.id
  	@status.save
    redirect_to home_path
  end
end
