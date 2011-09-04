class Song < ActiveRecord::Base

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
