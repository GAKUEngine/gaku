source 'http://production.s3.rubygems.org'

gem 'globalize3',  github: 'globalize/globalize', branch: 'rails4', ref: '82b3b36308677745b261bd147dda00ed4560a25d'

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
