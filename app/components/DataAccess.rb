require 'fileutils'
require_relative 'MediaManagerConfig'

class DataAccess

  def Config
    @Config
  end
  def Config=(config)
    @Config = config
  end

  def initialize(string)
    @configLocation = string
    @Config = MediaManagerConfig.new(self.ReadConfigFile)
    @movieExtensions = ['.avi', '.mp4', '.wmv']
    @musicExtensions = ['.mp3', '.ogg', '.wma']
  end

  #def initialize(movie, music)
  #  @movieDirectory = movie
  #  @musicDirectory = music
  #  @movieExtensions = ['.avi', '.mp4', '.wmv']
  #  @musicExtensions = ['.mp3', '.ogg', '.wma']
  #end

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

  def ReadConfigFile
    file  = File.new(@configLocation, "r")
    if line = file.gets
      file.close
      return line
    end
    return ""
  end

  def WriteConfigFile
    File.open(@configLocation, "w") do |f|  
      f.puts @Config.ToJson
    end
  end

end