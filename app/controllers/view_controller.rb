class ViewController < ApplicationController
  
  def index
    type = params[:type]
    if type.downcase == "song"
      @media = Song.find(params[:id])
    elsif type.downcase == "video"
      @media = Video.find(params[:id])
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
  end

end
