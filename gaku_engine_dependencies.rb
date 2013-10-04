source 'http://production.s3.rubygems.org'

gem 'pg'

gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier',     '>= 1.0.3'

gem 'globalize3',  github: 'svenfuchs/globalize3', branch: 'rails4'
gem 'gaku_helpers', github: 'kalkov/gaku_helpers'

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-cop'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'ffaker'
  gem 'shoulda-matchers', '~> 2.4.0'
  gem 'handy_controller_helpers', '0.0.3'
  gem 'capybara', '= 1.1.3'
  gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'coveralls', require: false
end

gemspec
