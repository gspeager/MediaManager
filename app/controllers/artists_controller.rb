class ArtistsController < ApplicationController
  def view
  	@artist = Artist.find_by_public_token(params[:id])
  end

end
