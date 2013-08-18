require 'active_record/fixtures'

namespace :db do
  desc %q{Loads a specified fixture file:
For .yml      use rake db:load_file[gaku/filename.yml,/absolute/path/to/parent/]
For .rb       use rake db:load_file[/absolute/path/to/sample/filename.rb]}

  task :load_file , [:file, :dir] => :environment do |t, args|
    file = Pathname.new(args.file)

    if %w{.yml}.include? file.extname
      puts "loading fixture: #{File.basename(args.file)}"
      ActiveRecord::Fixtures.create_fixtures(args.dir, file.to_s.sub(file.extname, ""))
    elsif file.exist?
      puts "loading ruby: #{File.basename(file)}"
      require file
    end
  end

  desc "Loads fixtures from the the dir you specify using rake db:load_dir[loadfrom]"
  task :load_dir , [:dir] => :environment do |t , args|
    dir = args.dir
    dir = File.join(Rails.root, "db", dir) if Pathname.new(dir).relative?

    fixtures = ActiveSupport::OrderedHash.new
    ruby_files = ActiveSupport::OrderedHash.new
    Dir.glob(File.join(dir , '**/*.{yml,csv,rb}')).each do |fixture_file|
      ext = File.extname fixture_file
      if ext == ".rb"
        ruby_files[File.basename(fixture_file, '.*')] = fixture_file
      else
        fixtures[fixture_file.sub(dir, "")[1..-1]] = fixture_file
      end
    end
    fixtures.sort.each do |relative_path , fixture_file|
      # an invoke will only execute the task once
      Rake::Task["db:load_file"].execute( Rake::TaskArguments.new([:file, :dir], [relative_path, dir]) )
    end
    ruby_files.sort.each do |fixture , ruby_file|
      # an invoke will only execute the task once
      Rake::Task["db:load_file"].execute( Rake::TaskArguments.new([:file], [ruby_file]) )
    end
  end

  desc "Migrate schema to version 0 and back up again. WARNING: Destroys all data in tables!!"
  task remigrate: :environment do
    require 'highline/import'

    if ENV['SKIP_NAG'] or ENV['OVERWRITE'].to_s.downcase == 'true' or agree("This task will destroy any data in the database. Are you sure you want to \ncontinue? [y/n] ")

      # Drop all tables
      ActiveRecord::Base.connection.tables.each { |t| ActiveRecord::Base.connection.drop_table t }

      # Migrate upward
      Rake::Task["db:migrate"].invoke

      # Dump the schema
      Rake::Task["db:schema:dump"].invoke
    else
      say "Task cancelled."
      exit
    end
  end

end
