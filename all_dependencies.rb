source 'http://production.s3.rubygems.org'


unless ENV['TRAVIS']
  group :development do
    gem 'guard'
    gem 'rubocop'
    gem 'guard-rspec'
    gem 'guard-bundler'
    gem 'guard-rubocop'
  end
end

group :test do
  gem 'capybara',                 '~> 2.1'
  gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'launchy'
  gem 'handy_controller_helpers', '0.0.3'
end


gemspec
