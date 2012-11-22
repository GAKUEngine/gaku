Capybara.default_selector = :css

Capybara.register_driver :selenium_firefox do |app|
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 180 # <= Page Load Timeout value in seconds
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :http_client => client)
end