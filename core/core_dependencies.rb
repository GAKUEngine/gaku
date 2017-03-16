source 'http://rubygems.org'

unless ENV['TRAVIS']
  group :development do
    gem 'guard'
    gem 'rubocop'
    gem 'guard-rspec'
    gem 'guard-bundler'
    gem 'guard-rubocop'
  end
end

group :development, :production do

end

group :test do
  gem 'rspec-rails',              '~> 3.6.0.beta2'
  gem 'factory_girl_rails',       '~> 4.8.0'
  gem 'database_cleaner',         '~> 1.3.0'
  gem 'shoulda-matchers',         '~> 2.8.0'
  gem 'rails-controller-testing'
  gem 'simplecov'
  gem 'coveralls', require: false
end
