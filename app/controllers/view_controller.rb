class ViewController < ApplicationController
  
  before_filter :user_not_logged_in_redirect

  def index
    type = params[:type]
    if type.downcase == "song"
      @media = Song.find_by_public_token(params[:id])
    elsif type.downcase == "video"
      @media = Video.find_by_public_token(params[:id])
    else
      @media = nil
    end

    if(current_user.id != @media.user_id)
      redirect_to home_path, :flash => {:error => "That media is not owned by you."}
    end
  end

  def play
    type = params[:type]
    if type.downcase == "song"
      @media = Song.find_by_public_token(params[:id])
    else type.downcase == "video"
      @media = Video.find_by_public_token(params[:id])  
    end
    if(current_user.id != @media.user_id)
      redirect_to home_path, :flash => {:error => "That media is not owned by you."}
    else
      send_file(DataAccess.getUserMusicDirectory(current_user.public_token) + @media.sub_path, :filename => @media.basenameAndExtension)
    end
  end

end
