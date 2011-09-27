class Song < ActiveRecord::Base
  
  belongs_to :artist
  belongs_to :album
  belongs_to :user

  before_create { initialize_song }

  self.per_page = 25

  has_attached_file :file,
                    :url  => "nil",
                    :path => DataAccess.getUserMusicDirectory(":user_id") + ":basename.:extension"

  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => ['audio/mpeg']
  
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



end
