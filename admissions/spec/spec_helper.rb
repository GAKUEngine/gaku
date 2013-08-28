require 'rubygems'
require 'spork'

if ENV['COVERAGE']
  # Run Coverage report
  require 'simplecov'
  puts 'Starting SimpleCov'
  SimpleCov.start do
    add_filter '/support/'
    add_filter '/support/requests/'
    add_filter '/spec/requests/**'
    add_filter '/config/**'
    add_group 'Controllers', 'app/controllers'
    add_group 'Helpers', 'app/helpers'
    add_group 'Workers', 'app/workers'
    add_group 'Mailers', 'app/mailers'
    add_group 'Models', 'app/models'
    add_group 'Libraries', 'lib'
  end
end

Spork.prefork do
  ENV['RAILS_ENV'] ||= 'test'
  require File.expand_path('../dummy/config/environment', __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'database_cleaner'
  require 'active_record/fixtures'
  require 'factory_girl_rails'

  require 'capybara/poltergeist'

  require 'gaku/testing/env'
  require 'gaku/testing/factories'
  require 'gaku/testing/controller_requests'
  require 'gaku/testing/request_helpers'
  require 'gaku/testing/flash_helpers'
  require 'gaku/testing/auth_helpers'

  require 'gaku/core/url_helpers'
  require 'factories'

  require 'coveralls'
  Coveralls.wear!
end

Spork.each_run do
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec

    config.before(:each) do
      if example.metadata[:js]
        DatabaseCleaner.strategy = :truncation
      else
        DatabaseCleaner.strategy = :transaction
      end
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.use_transactional_fixtures = false
    config.infer_base_class_for_anonymous_controllers = false

    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run focus: true
    config.run_all_when_everything_filtered = true

    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.include FactoryGirl::Syntax::Methods
    config.include Devise::TestHelpers, type: :controller
    config.include Gaku::Core::UrlHelpers
    config.include Gaku::Testing::ControllerRequests, type: :controller
    config.include Gaku::Testing::RequestHelpers, type: :request
    config.include Gaku::Testing::FlashHelpers, type: :request
    config.include Gaku::Testing::AuthHelpers::Controller, type: :controller
    config.include Gaku::Testing::AuthHelpers::Request, type: :request
  end
end
