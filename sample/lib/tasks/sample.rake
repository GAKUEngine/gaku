require 'ffaker'

namespace :db do
  desc 'Loads sample data'
  task :sample do
    say "Resetting database ..."
    Rake::Task["db:reset"].invoke

    sample_path = File.join(File.dirname(__FILE__), '..', '..', 'db', 'sample')
    Rake::Task['db:load_dir'].reenable
    Rake::Task['db:load_dir'].invoke(sample_path)
  end
end

