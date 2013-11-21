source 'http://production.s3.rubygems.org'

group :development do
  gem 'guard'
  gem 'rubocop'
  gem 'guard-rspec'1
  gem 'guard-bundler'
  gem 'guard-rubocop'
end

group :test do
  gem 'simplecov'
  gem 'coveralls', require: false
end

gemspec
