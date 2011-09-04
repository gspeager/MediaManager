class ViewController < ApplicationController
  
  def index
    type = params[:type]
    if type.downcase == "song"
      @media = Song.find(params[:id])
      #send_file @media.filename
    elsif type.downcase == "video"
      @media = Video.find(params[:id])
      #send_file @media.filename
    else
      @media = nil
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @media }
    end
  end

  def play
    type = params[:type]
    if type.downcase == "song"
      @media = Song.find(params[:id])
    else type.downcase == "video"
      @media = Video.find(params[:id])  
    end
    send_file(@media.filename, :filename => @media.basenameAndExtension)
    #send_file @media.filename
  end

end
