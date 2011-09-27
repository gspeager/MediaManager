class SongsController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_filter :user_not_logged_in_redirect

  # GET /songs
  # GET /songs.xml
  def index
    @songs = Song.find_by_user_id(current_user.id)
    if @songs
      @songs = Song.search(params[:search], params[:field]).where('user_id LIKE ?', current_user.id).page(params[:page]).order(sort_column + " " + sort_direction)
    end
    @song = Song.new
    @song.user_id = current_user.public_token
  end

  # GET /songs/1
  # GET /songs/1.xml
  def show
    @song = Song.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @song }
    end
  end

  # GET /songs/new
  # GET /songs/new.xml
  def new
    @song = Song.new
    @song.user_id = current_user.id
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @song }
    end
  end

  # GET /songs/1/edit
  def edit
    @song = Song.find(params[:id])
  end

  # POST /songs
  # POST /songs.xml
  def create
    @song = Song.new(params[:song])
    @song.user_id = current_user.id
    respond_to do |format|
      if @song.save
        @song.update_initial_song_info
        @song.save
        format.html { redirect_to(@song, flash => {:success => 'Song was successfully created.'}) }
        format.xml  { render :xml => @song, :status => :created, :location => @song }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @song.errors, flash => {:error => :unprocessable_entity} }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.xml
  def update
    @song = Song.find(params[:id])

    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html { redirect_to(@song, :notice => 'Song was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @song.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.xml
  def destroy
    @song = Song.find(params[:id])
    @song.destroy

    respond_to do |format|
      format.html { redirect_to(songs_url) }
      format.xml  { head :ok }
    end
  end

  def sort_column
    Song.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
