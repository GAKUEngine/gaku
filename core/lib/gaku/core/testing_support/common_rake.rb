unless defined?(Gaku::InstallGenerator)
  require 'generators/gaku/install/install_generator'
end

desc "Generates a dummy app for testing"
namespace :common do
  task :test_app do |t, args|

    require "#{ENV['LIB_NAME']}"

    ENV['DB_NAME'] = "mysql"

    puts "LIB_NAME : #{ENV['LIB_NAME']}"
    puts "DB_NAME : #{ENV['DB_NAME']}"

    Gaku::DummyGenerator.start ["--lib_name=#{ENV['LIB_NAME']}", "--database=#{ENV['DB_NAME']}", "--quiet"]
    Gaku::InstallGenerator.start ["--lib_name=#{ENV['LIB_NAME']}", "--auto-accept", "--migrate=false", "--seed=false", "--sample=false", "--quiet"]

    puts "Setting up dummy database..."
    cmd = "bundle exec rake db:drop db:create db:migrate db:test:prepare"

    if RUBY_PLATFORM =~ /mswin/ #windows
      cmd += " >nul"
    else
      cmd += " >/dev/null"
    end

    system(cmd)
  end
end
