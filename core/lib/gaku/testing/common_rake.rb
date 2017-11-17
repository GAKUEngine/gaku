unless defined?(Gaku::InstallGenerator)
  require 'generators/gaku/install/install_generator'
end

desc 'Generates a dummy app for testing'
namespace :common do
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

    db_accessible = false
    begin
      ActiveRecord::Base.establish_connection
      ActiveRecord::Base.connection
      db_accessible = true if ActiveRecord::Base.connected?
    rescue
      printf "Database was not accessible. How would you like to proceed?\n" \
        "(1) Try to create user and database manually (requires sudo)\n" \
        "(2) Attempt to run migrations. This requires the following:\n" \
        "\t * HStore installed\n" \
        "\t * Postgres user \"manabu\" with password \"manabu\"\n" \
        "\t * Database \"gaku_test\" and \"gaku_development\" with full permission granted to \"manabu\"\n" \
        "(3) Use \"manabu\" Postgres user (password \"manabu\"), assuming user has superuser status\n" \
        "Please enter 1, 2, or 3. Enter anything else or simply hit enter to cancel: "
      selection = STDIN.getc
      puts "Selection was #{selection.chr}"

      `sudo -u postgres psql -c "CREATE USER manabu WITH PASSWORD 'manabu';"`
      `sudo -u postgres psql -c "ALTER USER manabu CREATEDB;"`
      `sudo -u postgres psql -c "CREATE EXTENSION IF NOT EXISTS hstore;"`
      
      #`sudo -u postgres psql -c "DROP DATABASE gaku_test;"`
      #`sudo -u postgres psql -c "CREATE DATABASE gaku_test;"`
      #`sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE \"gaku_test\" to manabu;"`
      #`sudo -u postgres psql -c "ALTER DATABASE gaku_test OWNER TO manabu;"`
      #`sudo -u postgres psql -c "DROP DATABASE gaku_development;"`
      #`sudo -u postgres psql -c "CREATE DATABASE gaku_development;"`
      #`sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE \"gaku_development\" to manabu;"`
      #`sudo -u postgres psql -c "ALTER DATABASE gaku_development OWNER TO manabu;"`
      
      #`sudo -u postgres psql -c "ALTER ROLE manabu superuser;"`
      `bundle exec rails app:update:bin db:environment:set db:drop db:create db:migrate db:test:prepare RAILS_ENV=test`
      #`sudo -u postgres psql -c "ALTER ROLE manabu nosuperuser;"`
    end

    if db_accessible
      puts 'Database found and is accessible by manabu user. Assuming empty and preparing. To clear database run "rake drop_test_app".'
      #cmd = 'bundle exec rails app:update:bin db:environment:set db:migrate db:test:prepare RAILS_ENV=test'
      #cmd = 'bundle exec rails app:update:bin db:environment:set db:drop db:create db:migrate db:test:prepare RAILS_ENV=test'

      #if RUBY_PLATFORM =~ /mswin/ # windows
      #  cmd += ' >nul'
      #else
      #  cmd += ' >/dev/null'
      #end

      #system(cmd)
    end
  end
end
