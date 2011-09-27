require 'fileutils'
require 'yaml'
require 'rubygems'

class DataAccess

  @@movieExtensions = ['.mp4']
  @@musicExtensions = ['.mp3', '.mp4']

  def self.createUserDirectories(user_hash)
    if !File.directory?(ENVIRONMENT_CONFIG['media_directory'] + "/" + user_hash)
      Dir.mkdir(ENVIRONMENT_CONFIG['media_directory'] + "/" + user_hash)
      Dir.mkdir(ENVIRONMENT_CONFIG['media_directory'] + "/" + user_hash + "/music")
      Dir.mkdir(ENVIRONMENT_CONFIG['media_directory'] + "/" + user_hash + "/movies")
      Dir.mkdir(ENVIRONMENT_CONFIG['media_directory'] + "/" + user_hash + "/television")
      Dir.mkdir(ENVIRONMENT_CONFIG['media_directory'] + "/" + user_hash + "/photos")
    end
  end

  def self.getUserMusicDirectory(user_hash)
    return ENVIRONMENT_CONFIG['media_directory'] + "/" + user_hash + "/music/"
  end

  def self.getUserMovieDirectory(user_hash)
    return ENVIRONMENT_CONFIG['media_directory'] + "/" + user_hash + "/movies/"
  end

  def self.getUserTvDirectory(user_hash)
    return ENVIRONMENT_CONFIG['media_directory'] + "/" + user_hash + "/television/"
  end

  def self.getUserPhotoDirectory(user_hash)
    return ENVIRONMENT_CONFIG['media_directory']   + "/" + user_hash + "/photos/"
  end

  def self.MoveFile(oldFileName, newFileName)
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