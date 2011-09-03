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
end
