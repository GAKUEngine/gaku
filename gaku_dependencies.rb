source 'http://production.s3.rubygems.org'

unless ENV['TRAVIS']
	group :development do
	  gem 'guard'
	  gem 'rubocop'
	  gem 'guard-rspec'
	  gem 'guard-bundler'
	  gem 'guard-rubocop'
	end
end

group :test do
  gem 'simplecov'
  gem 'coveralls', require: false
end

gemspec
