require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../dummy/config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'database_cleaner'
  require 'active_record/fixtures'
  require 'factory_girl_rails'

  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist unless ENV['SELENIUM']
  Capybara.default_wait_time = 5
  
  require 'gaku/core/testing_support/factories'
  require 'gaku/core/testing_support/controller_requests'
  require 'gaku/core/testing_support/request_helpers'
  require 'gaku/core/testing_support/flash_helpers'
  require 'gaku/core/testing_support/auth_helpers'

  require 'gaku/core/url_helpers'
  require 'factories'

end



Spork.each_run do
  # This code will be run each time you run your specs.
  #Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
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

    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.include FactoryGirl::Syntax::Methods
    config.include Devise::TestHelpers, :type => :controller
    config.include Gaku::Core::UrlHelpers
    config.include Gaku::Core::TestingSupport::ControllerRequests, :type => :controller
    config.include Gaku::Core::TestingSupport::RequestHelpers, :type => :request
    config.include Gaku::Core::TestingSupport::FlashHelpers, :type => :request
    config.include Gaku::Core::TestingSupport::AuthHelpers::Controller, :type => :controller
    config.extend  Gaku::Core::TestingSupport::AuthHelpers::Request, :type => :request
  end

  RSpec::Matchers.define :have_valid_factory do |factory_name|
    match do |model|
      create(factory_name).new_record?.should be_false
    end
  end

end
