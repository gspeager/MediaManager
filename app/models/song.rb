class Song < ActiveRecord::Base

  self.per_page = 25
  
  def basenameAndExtension
    return File.basename(self.filename)
  end
  
  def getExtension
    return File.extname(self.filename)
  end

  def mediaType
    return "song"
  end

  def self.searchFields
    return {'title' => 'title', 'album' => 'album', 'artist' => 'artist', 'genre' => 'genre', 'owner' => 'owner'}
  end

  def self.search(searchTerm, searchColumn)
    if searchTerm && searchColumn
      where(searchColumn + ' LIKE ?', "%#{searchTerm}%")
    else
      scoped
    end
  end

end
