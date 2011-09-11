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

end
