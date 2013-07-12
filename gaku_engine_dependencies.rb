source 'http://production.s3.rubygems.org'

#DB
gem 'mysql2'
gem 'pg'
gem 'sqlite3'

gem 'therubyracer', require: 'v8'

gem 'rails-i18n'
gem 'gen_sheet'

gem 'rails4_upgrade'
gem 'paper_trail', github: 'airblade/paper_trail', branch: 'rails4'

gem 'devise', github: 'plataformatec/devise', branch: 'rails4'
gem 'ransack', github: 'ernie/ransack', branch: 'rails-4'
gem 'bootstrap-editable-rails', github: 'tkawa/bootstrap-editable-rails'
gem 'globalize3', github: 'svenfuchs/globalize3', branch: 'rails4'
gem 'deface', github: 'spree/deface', branch: 'master'

group :assets do
  gem 'less'
  gem 'sass-rails',   '~> 4.0.0.rc1'
  gem 'coffee-rails', '~> 4.0.0'
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
    gem 'rb-inotify' #this is not available for MacOS
  end
end

group :test do
  gem 'spork', '~> 1.0rc'
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'ffaker'
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers' , branch: 'dp-rails-four'

  gem 'capybara', '= 1.1.3'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'simplecov'
  gem 'coveralls', require: false

  gem 'poltergeist'
end

gemspec
