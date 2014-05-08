require_relative 'spec_helper_base'

require 'rspec/core'
require 'rspec/rails/extensions'
require 'rspec/rails/adapters'
# require 'rspec/rails/mocks'
require 'rspec/rails/view_rendering'
require 'rspec/rails/example'

require 'shoulda-matchers'
require 'database_cleaner'
require 'factory_girl_rails'
require 'handy_controller_helpers'

require 'gaku/testing/factories'
require 'gaku/testing/controller_helpers'
require 'gaku/testing/auth_helpers'
require 'gaku/core/url_helpers'

# require 'gaku/testing/support/controllers'

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
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
  config.include Devise::TestHelpers, type: :controller
  config.include HandyControllerHelpers::AllHelpers, type: :controller
  config.include Gaku::Core::UrlHelpers

  config.alias_it_should_behave_like_to :ensures, 'ensures'
end
