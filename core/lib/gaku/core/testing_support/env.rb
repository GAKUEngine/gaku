require 'capybara/poltergeist'

Capybara.default_selector = :css
Capybara.default_wait_time = 5

if ENV['SELENIUM']
  Capybara.javascript_driver = :selenium
elsif ENV['PHANTOMJS']
  Capybara.javascript_driver = :poltergeist
else
  Capybara.javascript_driver = :selenium
end