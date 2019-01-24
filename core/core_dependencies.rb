source 'https://rubygems.org'

# unless ENV['TRAVIS']
#   group :development do
#     # gem 'guard'
#     # gem 'rubocop'
#     # gem 'guard-rspec'
#     # gem 'guard-bundler'
#     # gem 'guard-rubocop'
#   end
# end

group :development, :test do
  gem 'pry'
  gem 'listen'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rubocop-rspec'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
  gem 'simplecov'
  gem 'coveralls', require: false
end
