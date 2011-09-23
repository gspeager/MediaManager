class HomeController < ApplicationController
  def index
  	if current_user
      redirect_to home_path
    else

    end
  end
end
