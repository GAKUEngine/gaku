require 'capybara/poltergeist'

Capybara.default_selector = :css
Capybara.default_wait_time = 5

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, { debug: true })
end

if ENV['PHANTOM']
  Capybara.javascript_driver = :poltergeist
else
  Capybara.javascript_driver = :selenium
end