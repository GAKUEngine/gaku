require 'capybara/poltergeist'

Capybara.default_selector = :css
Capybara.default_wait_time = 5

if ENV['SELENIUM']
  Capybara.javascript_driver = :selenium
else
  Capybara.javascript_driver = :selenium
end