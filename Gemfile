source 'https://rubygems.org'

gem 'rails', '~> 3.2.4'
gem 'rails-i18n'

gem 'slim-rails'

gem 'inherited_resources'

gem 'jquery-rails'
gem 'kendoui-rails'

gem 'devise', :git => "git://github.com/plataformatec/devise.git"
gem 'devise-i18n'

gem 'execjs'
gem 'therubyracer'

gem 'app_config'

gem 'seedbank'
gem 'annotate'

gem 'paperclip'

gem 'chosen-rails'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'hirb'
  gem 'awesome_print'
end

group :test do
  gem 'rspec-rails', '~> 2.10.1'
  gem 'factory_girl_rails', '~> 1.7.0'
  gem 'ffaker'
  gem 'shoulda-matchers', '~> 1.0.0'
  gem 'capybara'
  gem 'selenium-webdriver','2.20.0'
  gem 'database_cleaner', '0.7.1'
  gem 'launchy'
  
  gem 'guard'
  gem 'guard-rspec', '~> 0.6.0'
  gem 'guard-bundler'
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
