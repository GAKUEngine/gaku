source 'https://rubygems.org'

unless ENV['TRAVIS']
  group :development do
    # gem 'guard'
    # gem 'rubocop'
    # gem 'guard-rspec'
    # gem 'guard-bundler'
    # gem 'guard-rubocop'
  end
end

group :development, :test do
  gem 'pry'
end

group :test do
  gem 'rspec-rails',              '~> 3.7.2'
  gem 'factory_bot_rails',        '~> 4.11.1'
  gem 'database_cleaner',         '~> 1.3.0'
  gem 'shoulda-matchers',         '~> 3.1.2'
  gem 'rails-controller-testing'
  gem 'simplecov'
  gem 'coveralls', require: false
end
