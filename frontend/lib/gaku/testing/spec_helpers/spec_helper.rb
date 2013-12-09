require_relative 'spec_helper_base'
require 'rubygems'

require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'
require 'active_record/fixtures'
require 'factory_girl_rails'
require 'ffaker'

require 'gaku/testing/env'
require 'gaku/testing/factories'
require 'gaku/testing/feature_helpers'
require 'gaku/testing/flash_helpers'
require 'gaku/testing/auth_helpers'
require 'gaku/core/url_helpers'


#require 'gaku/testing/support/features'

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|

  config.before(:each) do
    if example.metadata[:js]
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end

    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end


  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include FactoryGirl::Syntax::Methods
  config.include Gaku::Core::UrlHelpers

end