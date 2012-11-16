require 'app_config'

AppConfig.setup do |config|
  config[:storage_method] = :yaml
  config[:path] = "#{Rails.root}/core/config/app_config.yml"
end