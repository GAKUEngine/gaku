source 'https://rubygems.org'

#Rails
gem 'rails', '~> 3.2.8'
gem 'rails-i18n'
gem 'audited-activerecord', '~> 3.0'
gem 'slim-rails'
gem 'inherited_resources'
gem 'chosen-rails'
gem 'ransack'
#gem 'attr_encrypted'

#JS 
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'kendoui-rails'
gem 'execjs'
gem 'therubyracer'
gem 'i18n-js', :git => "git://github.com/fnando/i18n-js.git"
gem 'backbone-on-rails'

#gem 'devise', :git => "git://github.com/plataformatec/devise.git"
gem 'devise', '~> 2.1'
gem 'devise-i18n'
gem 'cancan'

gem 'paperclip'
gem 'app_config'
gem 'seedbank'
gem 'spreadsheet'
gem 'roo' #TODO consider other options for roo?

group :production do
  gem 'unicorn' 
end

group :assets do
  gem 'less'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'sqlite3'
  gem 'annotate'
  gem "rails-erd"
  gem 'hirb'
  gem 'awesome_print'
  gem 'highline'
  gem 'rails-footnotes', '>= 3.7.5.rc4'
end

group :test do
  gem 'mysql2'
  gem 'spork', '~> 1.0rc'
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 3.2.0'
  gem 'ffaker'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'launchy'
  
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
