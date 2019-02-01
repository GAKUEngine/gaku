ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)

require 'gaku/testing/spec_helpers/spec_helper'
Dir["#{File.dirname(__FILE__)}/support/features/**/*.rb"].each { |f| require f }

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_group 'Controllers', 'app/controllers'
end

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers, type: :request
end
