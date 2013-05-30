require 'highline/import'

namespace :gaku do
  namespace :db do

    desc "!!! Reset DB and delete migrations !!!"
    task :reset => :environment do
      say "!!! Reset DB and delete migrations !!!"

      dir = "#{Rails.root}/db/migrate"
      FileUtils.rm_rf("#{dir}/.", secure: true)
      say "Migrations deleted!"

      Rake::Task["db:drop"].invoke
      say "Database dropped!"
    end

  end


  desc "Reset db + delete migrations and run generator + load sample data"
  task :reset_app => :environment do
    unless Rails.env.production?
      say "rake db:drop"
      Rake::Task["db:drop"].invoke

      say "rake db:create"
      Rake::Task["db:create"].invoke

      say "rails g gaku:install"
      system('rails g gaku:install')

      #say "rake gaku:sample:load"
      #Rake::Task["gaku:sample:load"].invoke
    end
  end
end
