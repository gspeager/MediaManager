class MediaManagerConfig

  def MovieDirectory
    @movieDirectory
  end
  def MovieDirectory=(movie)
    @movieDirectory = movie
  end

  def MusicDirectory
    @musicDirectory
  end
  def MusicDirectory=(music)
    @musicDirectory = music
  end

  def OrganizeDirectories
    @organizeDirectories
  end
  def OrganizeDirectories=(organize)
    @organizeDirectories = organize
  end

  def initialize(movie, music, organize)
    @movieDirectory = movie
    @musicDirectory = music
    @organizeDirectories = organize
  end

  def ToJson
  	return ActiveSupport::JSON.encode(self)
  end

end