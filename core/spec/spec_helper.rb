require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

# figure out where we are being loaded from
if $LOADED_FEATURES.grep(/spec\/spec_helper\.rb/).any?
  begin
    raise "foo"
  rescue => e
    puts <<-MSG
  ===================================================
  It looks like spec_helper.rb has been loaded
  multiple times. Normalize the require to:

    require "spec/spec_helper"

  Things like File.join and File.expand_path will
  cause it to be loaded multiple times.

  Loaded this time from:

    #{e.backtrace.join("\n    ")}
  ===================================================
    MSG
  end
end

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../dummy/config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'database_cleaner'
  require 'active_record/fixtures'
  require 'factory_girl_rails'
  require "paperclip/matchers"
  require 'sidekiq/testing'

  require 'gaku/core/testing_support/env'
  require 'gaku/core/testing_support/factories'
  require 'gaku/core/testing_support/controller_requests'
  require 'gaku/core/testing_support/request_helpers'
  require 'gaku/core/testing_support/flash_helpers'
  require 'gaku/core/testing_support/auth_helpers'

  require 'gaku/core/url_helpers'
end


Spork.each_run do
  # This code will be run each time you run your specs.
  #Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  Dir["#{File.dirname(__FILE__)}/support/*.rb"].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec

    config.before(:all) do
      DeferredGarbageCollection.start
    end

    config.before(:each) do
      if example.metadata[:js]
        DatabaseCleaner.strategy = :truncation
      else
        DatabaseCleaner.strategy = :transaction
      end

      DatabaseCleaner.start
      @routes = Gaku::Core::Engine.routes
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.after(:all) do
      DeferredGarbageCollection.reconsider
    end

    config.use_transactional_fixtures = false
    config.infer_base_class_for_anonymous_controllers = false

    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.include FactoryGirl::Syntax::Methods
    config.include Paperclip::Shoulda::Matchers
    config.include Devise::TestHelpers, :type => :controller
    config.include Gaku::Core::UrlHelpers
    config.include Gaku::Core::TestingSupport::ControllerRequests, :type => :controller
    config.include Gaku::Core::TestingSupport::RequestHelpers, :type => :request
    config.include Gaku::Core::TestingSupport::FlashHelpers, :type => :request
    config.extend  Gaku::Core::TestingSupport::AuthHelpers::Controller, :type => :controller
    config.extend  Gaku::Core::TestingSupport::AuthHelpers::Request, :type => :request
    config.include ActionView::TestCase::Behavior, example_group: {file_path: %r{spec/presenters}}

    config.alias_it_should_behave_like_to :ensures, "ensures"
  end

end
