source 'http://production.s3.rubygems.org'

group :development, :production do
  gem 'localeapp'
end

group :test do
  gem 'rspec-rails',              '~> 2.14.1'
  gem 'factory_girl_rails',       '~> 4.4.0'
  gem 'database_cleaner',         '~> 1.2'
  gem 'shoulda-matchers',         '~> 2.5.0'
  gem 'simplecov'
  gem 'coveralls', require: false
end

gemspec
