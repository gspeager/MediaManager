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

      file_begin = 0
      file_size = @media.file_file_size 
      file_end = file_size - 1

      if !request.headers["Range"]
        status_code = "200 OK"
      else
        status_code = "206 Partial Content"
        match = request.headers['range'].match(/bytes=(\d+)-(\d*)/)
        if match
          file_begin = match[1]
          file_end = match[1] if match[2] && !match[2].empty?
        end
        response.header["Content-Range"] = "bytes " + file_begin.to_s + "-" + file_end.to_s + "/" + file_size.to_s
      end
      response.header["Content-Length"] = (file_end.to_i - file_begin.to_i + 1).to_s
      response.header["Last-Modified"] = @media.file_updated_at.to_s

      response.header["Cache-Control"] = "public, must-revalidate, max-age=0"
      response.header["Pragma"] = "no-cache"
      response.header["Accept-Ranges"]=  "bytes"
      response.header["Content-Transfer-Encoding"] = "binary"
      send_file(DataAccess.getUserMusicDirectory(current_user.public_token) + @media.sub_path, 
                :filename => @media.file_file_name,
                :type => @media.file_content_type, 
                :disposition => "inline",
                :status => status_code,
                :stream =>  'true',
                :buffer_size  =>  4096)
      
    end
  end
end
