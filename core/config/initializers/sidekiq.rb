require 'sidekiq'
#Sidekiq.configure_server do |config|
#  config.redis = { url: 'redis://redistogo:23997367276d9d8e473756154c3da248@spadefish.redistogo.com:9679/'}
#end

ENV['REDISTOGO_URL'] = 'redis://redistogo:23997367276d9d8e473756154c3da248@spadefish.redistogo.com:9679/'
