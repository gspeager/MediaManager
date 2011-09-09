require 'fileutils'
require 'yaml'
require 'rubygems'
require 'song'
require 'video'
require 'mp3info'

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
    @movieExtensions = ['.mp4']
    @musicExtensions = ['.mp3', '.mp4']
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
    if(File.extname(filename) == ".mp3") 
      Mp3Info.open(filename) do |mp3|
        s.title = !mp3.tag.title && !s.title ? File.basename(filename, File.extname(filename)) : mp3.tag.title
        s.artist = mp3.tag.artist if mp3.tag.artist
        s.album = mp3.tag.album if mp3.tag.album
        s.tracknumber = mp3.tag.tracknum if mp3.tag.tracknum
        s.length = mp3.tag.length if mp3.tag.length
        s.year = mp3.tag.year if mp3.tag.year
        s.length = Time.at(mp3.length).gmtime.strftime('%M:%S')
      end
      s.save
    else
      if s.title == nil || s.title.emtpy?
        s.title = File.basename(filename, File.extname(filename))
        s.save
      end
    end
    s.save
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