source 'https://rubygems.org'

#DB
gem 'mysql2'
gem 'pg'
gem 'sqlite3'

gem 'execjs'
gem 'therubyracer'

gem 'rails-i18n'

group :assets do
  gem 'less'
  gem 'sass-rails',   '~> 3.2'
  gem 'coffee-rails', '~> 3.2'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'annotate'
  gem "rails-erd"
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

  gem 'poltergeist'

  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-spork'

  if RUBY_PLATFORM =~ /darwin/
    gem 'growl'
    gem 'rb-fsevent', '~> 0.9.1' #guard dependency
  end
end

unless ENV["CI"]
  platform :ruby_18 do
    gem 'rcov'
    gem 'ruby-debug'
  end
  platform :ruby_19 do
    gem 'simplecov'
    gem 'ruby-debug19'
  end
end

gemspec
