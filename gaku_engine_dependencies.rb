#source 'https://rubygems.org'
source 'http://production.s3.rubygems.org'

#DB
gem 'mysql2'
gem 'pg'
gem 'sqlite3'

gem 'therubyracer', :require => 'v8'

gem 'rails-i18n'

group :assets do
  gem 'less'
  gem 'sass-rails',   '~> 3.2'
  gem 'coffee-rails', '~> 3.2'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-spork'
  gem 'rubocop'
  gem 'guard-cop'

  if RUBY_PLATFORM =~ /darwin/
    gem 'growl'
    gem 'rb-fsevent', '~> 0.9.1' #guard dependency
  else
    gem 'rb-inotify', '~> 0.8.8' #this is not available for MacOS
  end
end

group :test do
  gem 'spork', '~> 1.0rc'
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 3.2.0'
  gem 'ffaker'
  gem 'shoulda-matchers'
  gem 'capybara', '= 1.1.3'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'simplecov'
  gem 'coveralls', require: false

  gem 'poltergeist'
end

gemspec
