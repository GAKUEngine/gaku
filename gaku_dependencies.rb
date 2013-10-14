source 'http://production.s3.rubygems.org'

group :development do
  gem 'guard'
  gem 'rubocop'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-rubocop'
  gem 'guard-minitest', github: 'guard/guard-minitest'
end

group :test do
  gem 'simplecov'
  gem 'coveralls', require: false
end

gemspec
