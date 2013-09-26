source 'http://production.s3.rubygems.org'

gem 'pg'

gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier',     '>= 1.0.3'

gem 'paper_trail', github: 'airblade/paper_trail', branch: 'master'
gem 'globalize3',  github: 'svenfuchs/globalize3', branch: 'rails4'

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
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers' , branch: 'dp-rails-four'
  gem 'handy_controller_helpers', '0.0.2'
  gem 'capybara', '= 1.1.3'
  gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'coveralls', require: false
end

gemspec
