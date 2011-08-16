require 'fileutils'

class DataAccess

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

  def initialize(movie, music)
    @movieDirectory = movie
    @musicDirectory = music
    @movieExtensions = ['.avi', '.mp4', '.wmv']
    @musicExtensions = ['.mp3', '.ogg', '.wma']
  end

  def ReadMovieDirectory
    movieArray = GetAllFiles(@movieDirectory, @movieExtensions)
    movieArray.each { |f|
      puts f
    }
  end

  def ReadMusicDirectory 
    musicArray = GetAllFiles(@musicDirectory, @musicExtensions)
    musicArray.each { |f|
      puts f
    }
  end

  def GetAllFiles(directoryName, extensionList)
    resultArray = Array.new
    Dir.chdir(directoryName)
    Dir.entries(directoryName).each { |f|
      next if f == '.' || f == '..'
      if File.directory?(f)
        resultArray.push(GetAllFiles(directoryName + "\\" + f, extensionList))
        Dir.chdir(directoryName)
      else
        if extensionList.include?(File.extname(f))
          resultArray.push(File.absolute_path(f))
        end
      end
    }
    return resultArray
  end

  def MoveFile(oldFileName, newFileName)
    if !File.directory?(File.dirname(newFileName))
      FileUtils.mkdir_p(File.dirname(newFileName))
    end
    FileUtils.mv(oldFileName, newFileName)
  end

end