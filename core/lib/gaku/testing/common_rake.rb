unless defined?(Gaku::InstallGenerator)
  require 'generators/gaku/install/install_generator'
end

desc 'Generates a dummy app for testing'
namespace :common do
  task :start_testing do
    dir = "cd #{__dir__}/../../../../docker"
    puts `#{dir} && docker-compose up -d`
  end

  task :stop_testing do
    dir = "cd #{__dir__}/../../../../docker"
    puts `#{dir} && docker-compose down -v`
  end

  task :test_app do

    require "#{ENV['LIB_NAME']}"

    puts ENV['LIB_NAME']

    Gaku::DummyGenerator.start ["--lib_name=#{ENV['LIB_NAME']}", '--quiet']
    Gaku::InstallGenerator.start ["--lib_name=#{ENV['LIB_NAME']}",
                                  '--auto-accept',
                                  '--migrate=false',
                                  '--seed=false',
                                  '--sample=false',
                                  '--quiet'
                                 ]

    puts 'Setting up dummy database...'

    Rake::Task['start_testing'].invoke
    `bundle exec rails app:update:bin db:environment:set db:drop db:create db:migrate RAILS_ENV=test`
  end
end

def _autopilot_setup
  term_cover = " 1> /dev/null 2> /dev/null"
  puts "Setting up DB User, Database, and Extensions..."
  `sudo -u postgres psql -c "CREATE USER manabu WITH PASSWORD 'manabu';"#{term_cover}`
  `sudo -u postgres psql -c "ALTER USER manabu CREATEDB;"#{term_cover}`
  `sudo -u postgres psql -c "CREATE EXTENSION IF NOT EXISTS hstore;"#{term_cover}`

  `sudo -u postgres psql -c "DROP DATABASE gaku_test;"#{term_cover}`
  `sudo -u postgres psql -c "CREATE DATABASE gaku_test;"#{term_cover}`
  `sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE \"gaku_test\" to manabu;"#{term_cover}`
  `sudo -u postgres psql gaku_test -c "CREATE EXTENSION hstore;"#{term_cover}`
  `sudo -u postgres psql -c "ALTER DATABASE gaku_test OWNER TO manabu;"#{term_cover}`
  
  `sudo -u postgres psql -c "DROP DATABASE gaku_development;"#{term_cover}`
  `sudo -u postgres psql -c "CREATE DATABASE gaku_development;"#{term_cover}`
  `sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE \"gaku_development\" to manabu;"#{term_cover}`
  `sudo -u postgres psql gaku_development -c "CREATE EXTENSION hstore;"#{term_cover}`
  `sudo -u postgres psql -c "ALTER DATABASE gaku_development OWNER TO manabu;"#{term_cover}`
  puts "Done."

  puts "Running tasks..."
  puts "Done. If the test app does not run normally please follow the setup guide at: "
  puts "https://github.com/GAKUEngine/gaku"
end
