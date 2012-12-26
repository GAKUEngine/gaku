require 'capybara/poltergeist'

Capybara.default_selector = :css
Capybara.default_wait_time = 5

if ENV['SELENIUM']
  Capybara.javascript_driver = :selenium
elsif ENV['PHANTOMJS']
  Capybara.javascript_driver = :poltergeist
else
  Capybara.javascript_driver = :poltergeist
end

#Capybara.register_driver :selenium_firefox do |app|
#  client = Selenium::WebDriver::Remote::Http::Default.new
#  client.timeout = 180 # <= Page Load Timeout value in seconds
#  Capybara::Selenium::Driver.new(app, :browser => :firefox, :http_client => client)
#end
