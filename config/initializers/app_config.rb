require 'app_config'

AppConfig.setup do |config|
  config[:storage_method] = :yaml
  config[:path] = "#{Rails.root}/config/app_config.yml"
end