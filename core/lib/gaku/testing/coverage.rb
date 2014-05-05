if ENV['COVERAGE']
  # Run Coverage report
  require 'rubygems'
  require 'coveralls'
  Coveralls.wear!

  require 'simplecov'
  puts 'Starting SimpleCov'
  SimpleCov.start do
    add_filter '/support/'
    add_filter '/support/requests/'
    add_filter '/spec/requests/**'
    add_filter '/config/**'
    add_group 'Controllers', 'app/controllers'
    add_group 'Helpers', 'app/helpers'
    add_group 'Mailers', 'app/mailers'
    add_group 'Models', 'app/models'
    add_group 'Libraries', 'lib'
  end
end
