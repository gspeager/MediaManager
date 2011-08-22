require 'fileutils'
require 'yaml'
require 'rubygems'

class DataAccess < ActiveRecord::Base

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
    #dbconfig = YAML::load(File.open('database.yml'))
    #ActiveRecord::Base.establish_connection(dbconfig)
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

  def WriteConfigFile
    puts CONFIG_LOCATION
    APP_CONFIG[Rails.env] = ENVIRONMENT_CONFIG
    File.open(CONFIG_LOCATION, "w") do |f|  
      f.puts YAML::dump(APP_CONFIG)
    end
  end

end