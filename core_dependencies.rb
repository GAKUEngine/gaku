source 'http://production.s3.rubygems.org'

group :test do
  gem 'rspec-rails',              '~> 2.14'
  gem 'factory_girl_rails',       '~> 4.4.0'
  gem 'database_cleaner',         '~> 1.1.1'
  gem 'shoulda-matchers',         '~> 2.4.0'
  gem 'simplecov'
  gem 'coveralls', require: false
end

gemspec
