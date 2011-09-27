require 'mp3info'
require 'DataAccess'

CONFIG_LOCATION = "#{Rails.root}/config/config.yml"
APP_CONFIG = YAML.load_file(CONFIG_LOCATION)
ENVIRONMENT_CONFIG = APP_CONFIG[Rails.env]