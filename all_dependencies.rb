source 'http://production.s3.rubygems.org'

group :test do
  gem 'capybara',                 '~> 2.1'
  gem 'selenium-webdriver',       '~> 2.39'
  gem 'poltergeist'
  gem 'launchy'
  gem 'handy_controller_helpers', '0.0.3'
end

gemspec
