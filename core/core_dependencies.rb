source 'https://rubygems.org'

group :development, :test do
  gem 'pry'
  gem 'listen'
end

group :test do
  gem 'rspec-rails',              '~> 3.8.2'
  gem 'factory_bot_rails',        '~> 4.11.1'
  gem 'database_cleaner',         '~> 1.7.0'
  gem 'shoulda-matchers',         '~> 3.1.2'
  gem 'rails-controller-testing'
  gem 'simplecov'
end
