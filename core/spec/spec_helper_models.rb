#require 'rubygems'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
require 'rspec/core'
require 'rspec/rails/extensions'
require 'rspec/rails/adapters'
require 'rspec/rails/matchers'
require 'rspec/rails/mocks'

#require 'rspec/autorun'

require 'database_cleaner'
require 'factory_girl_rails'
require 'paperclip/matchers'
require 'ffaker'
require 'shoulda-matchers'
require 'gaku/testing/factories'
require 'gaku/testing/deferred_garbage_collection'
require 'gaku/testing/coverage'


Dir["#{File.dirname(__FILE__)}/support/models/**/*.rb"].each { |f| require f }
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.mock_with :rspec

  config.before(:all) do
    DeferredGarbageCollection.start
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:all) do
    DeferredGarbageCollection.reconsider
  end

  config.order = 'random'

  config.include FactoryGirl::Syntax::Methods
  config.include Paperclip::Shoulda::Matchers
end