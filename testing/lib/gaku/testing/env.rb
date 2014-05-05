require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.default_selector = :css
Capybara.default_wait_time = 5
Capybara.default_driver = :rack_test

Capybara.register_driver :poltergeist_debug do |app|
  Capybara::Poltergeist::Driver.new(app, inspector: true, js_errors: false)
end

if ENV['SELENIUM']
  Capybara.javascript_driver = :selenium
elsif ENV['PHANTOM']
  Capybara.javascript_driver = :poltergeist_debug
else
  Capybara.javascript_driver = :poltergeist_debug
end
