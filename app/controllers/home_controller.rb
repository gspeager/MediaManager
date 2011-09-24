class HomeController < ApplicationController
  def index
  	if current_user
      redirect_to home_path
    else
      render :layout => 'full_page'
    end
  end
end
