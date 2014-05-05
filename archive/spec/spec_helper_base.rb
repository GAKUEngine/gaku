ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)

require 'gaku/testing/deferred_garbage_collection'
require 'gaku/testing/coverage'

Rails.logger.level = 3

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'

  config.before(:all) do
    DeferredGarbageCollection.start
  end

  config.after(:all) do
    DeferredGarbageCollection.reconsider
  end
end
