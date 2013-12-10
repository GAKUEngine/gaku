ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)

Dir["#{File.dirname(__FILE__)}/support/features/**/*.rb"].each { |f| require f }
require 'gaku/testing/spec_helpers/spec_helper'
