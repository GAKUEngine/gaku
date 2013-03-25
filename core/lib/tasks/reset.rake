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
end
