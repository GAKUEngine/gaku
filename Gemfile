source 'https://rubygems.org'

#Rails
gem 'rails', '~> 3.2.4'
gem 'rails-i18n'
gem 'slim-rails'
gem 'inherited_resources'
gem 'chosen-rails'
gem 'attr_encrypted'

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
end

group :test do
  gem 'mysql2'
  gem 'spork', '~> 1.0rc'
  gem 'rspec-rails', '~> 2.10.1'
  gem 'factory_girl_rails', '~> 1.7.0'
  gem 'ffaker'
  gem 'shoulda-matchers', '~> 1.0.0'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner', '0.7.1'
  gem 'launchy'
  
  gem 'guard'
  gem 'guard-rspec', '~> 0.6.0'
  gem 'guard-bundler'
  gem 'guard-spork'
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
