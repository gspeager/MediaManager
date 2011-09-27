class Song < ActiveRecord::Base
  
  belongs_to :artist
  belongs_to :album
  belongs_to :user

  before_create { initialize_song }
  before_save { relocate_song_file }

  self.per_page = 25

  has_attached_file :file,
                    :url  => "nil",
                    :path => DataAccess.getUserMusicDirectory(":user_id") + ":basename.:extension"

  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => ['audio/mpeg', 'audio/mp3']
  
  def basenameAndExtension
    return File.basename(self.file_file_name)
  end
  
  def getExtension
    return File.extname(self.file_file_name)
  end

  def mediaType
    return "song"
  end

  def self.searchFields
    return {'title' => 'title', 'album' => 'album', 'artist_id' => 'artist_id', 'genre' => 'genre'}
  end

  def self.search(searchTerm, searchColumn)
    if searchTerm && searchColumn
      where(searchColumn + ' LIKE ?', "%#{searchTerm}%")
    else
      scoped
    end
  end

  def getAttachmentPath
    DataAccess.getUserMusicDirectory(user_id) + SecureRandom.hex + ".:extension"
  end

  def update_initial_song_info
    if(File.extname(self.file_file_name) == ".mp3") 
      Mp3Info.open(DataAccess.getUserMusicDirectory(self.user.public_token) + self.file_file_name) do |mp3|
        self.title = !mp3.tag.title && !self.title ? File.basename(self.file_file_name, File.extname(self.file_file_name)) : mp3.tag.title
        if mp3.tag.artist
          artist = Artist.find_or_create_by_name(mp3.tag.artist)
          artist.save
          self.artist_id = artist.id
        end
        if mp3.tag.album
          album = Album.find_or_create_by_name(mp3.tag.album)
          album.artist_id = self.artist_id if self.artist_id
          album.save
          self.album_id = album.id
        end  
        self.tracknumber = mp3.tag.tracknum if mp3.tag.tracknum
        self.year = mp3.tag.year if mp3.tag.year
        self.length = Time.at(mp3.length).gmtime.strftime('%M:%S')
      end
    else
      if self.title == nil || self.title.emtpy?
        self.title = File.basename(self.file_file_name, File.extname(self.file_file_name))
      end
    end
  end

  def sub_path
    result = ""
    if self.artist_id
      result = result + self.artist.name + "/"
    end
    if self.album_id
      result = result + self.album.name + "/"
    end
    if self.tracknumber
      result = result + self.tracknumber.to_s + " - "
    end
    if self.title
      result = result + self.title + File.extname(self.file_file_name)
    else
      result = self.file_file_name
    end
    return result
  end

  private

  # interpolate in paperclip
  Paperclip.interpolates :user_id  do |attachment, style|
    attachment.instance.user.public_token
  end

  def initialize_song
    generate_token(:public_token)
    set_listen_count 
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Song.exists?(column => self[column])
  end

  def set_listen_count
    self.playcount = 0
  end

  def relocate_song_file
    if self.id
      song = Song.find(self.id)
      if song && song.sub_path != self.sub_path
        DataAccess.MoveFile(DataAccess.getUserMusicDirectory(self.user.public_token) + song.sub_path, DataAccess.getUserMusicDirectory(self.user.public_token) + self.sub_path)
        self.file_file_name = File.basename(self.sub_path) 
      end
    end
  end

end
