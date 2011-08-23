require 'fileutils'
require 'yaml'
require 'rubygems'
require 'song'
require 'video'

class DataAccess

  def MusicDirectory
    return ENVIRONMENT_CONFIG['music_directory']
  end
  def MusicDirectory=(music)
    ENVIRONMENT_CONFIG['music_directory'] = music
  end

  def MovieDirectory
    return ENVIRONMENT_CONFIG['movie_directory']
  end
  def MovieDirectory=(movie)
    ENVIRONMENT_CONFIG['movie_directory'] = movie
  end

  def OrganizeFiles
    return ENVIRONMENT_CONFIG['organize']
  end
  def OrganizeFiles=(value)
    ENVIRONMENT_CONFIG['organize'] = value
  end

  def initialize()
    @movieExtensions = ['.avi', '.mp4', '.wmv']
    @musicExtensions = ['.mp3', '.ogg', '.wma']
  end

  def ReadMovieDirectory
    movieArray = GetAllFiles(ENVIRONMENT_CONFIG['movie_directory'], @movieExtensions)
    movieArray.each { |f|
      InsertVideo(f)
    }
  end

  def ReadMusicDirectory 
    musicArray = GetAllFiles(ENVIRONMENT_CONFIG['music_directory'], @musicExtensions)
    musicArray.each { |f|
      InsertSong(f)
    }
  end

  def GetAllFiles(directoryName, extensionList)
    resultArray = Array.new
    Dir.chdir(directoryName)
    Dir.entries(directoryName).each { |f|
      next if f == '.' || f == '..'
      if File.directory?(f)
        resultArray = resultArray + GetAllFiles(directoryName + "\\" + f, extensionList)
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

  def InsertSong(filename)
    s = Song.find_or_initialize_by_filename(filename)
    if s.title == nil || s.title.emtpy?
      s.title = File.basename(filename, File.extname(filename))
      s.save
    end
  end
  def InsertVideo(filename)
    v = Video.find_or_initialize_by_filename(filename)
    if v.title == nil || v.title.emtpy?
      v.title = File.basename(filename, File.extname(filename))
      v.save
    end
  end

  def WriteConfigFile
    puts CONFIG_LOCATION
    APP_CONFIG[Rails.env] = ENVIRONMENT_CONFIG
    File.open(CONFIG_LOCATION, "w") do |f|  
      f.puts YAML::dump(APP_CONFIG)
    end
  end

end