require_relative 'spec_helper_base'

require 'rspec/core'
require 'rspec/rails/extensions'
require 'rspec/rails/adapters'
require 'rspec/rails/matchers'
# require 'rspec/rails/mocks'

require 'database_cleaner'
require 'factory_girl_rails'
require 'paperclip/matchers'
require 'ffaker'
# require 'shoulda-matchers'

require 'gaku/testing/factories'

Dir["#{File.dirname(__FILE__)}/support/models/**/*.rb"].each { |f| require f }

# ActiveRecord::Migration[4.2].check_pending! if defined?(ActiveRecord::Migration[4.2])
require 'shoulda/matchers'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
  with.test_framework :rspec
  with.library :rails
  end
end
RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
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

  config.include FactoryGirl::Syntax::Methods
  config.include Paperclip::Shoulda::Matchers

end
