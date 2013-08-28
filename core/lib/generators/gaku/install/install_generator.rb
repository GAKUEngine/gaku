require 'rails/generators'
require 'highline/import'
require 'bundler'
require 'bundler/cli'

module Gaku
  class InstallGenerator < Rails::Generators::Base

    class_option :migrate, type: :boolean, default: true, banner: 'Run Gaku migrations'
    class_option :seed, type: :boolean, default: true, banner: 'load seed data (migrations must be run)'
    class_option :auto_accept, type: :boolean
    class_option :lib_name, type: :string, default: 'gaku'
    class_option :env, type: :string, default: 'development'

    def self.source_paths
      paths = self.superclass.source_paths
      paths << File.expand_path('../templates', "../../#{__FILE__}")
      paths << File.expand_path('../templates', "../#{__FILE__}")
      paths << File.expand_path('../templates', __FILE__)
      paths.flatten
    end

    def prepare_options
      @env = options[:env]
      @run_migrations = options[:migrate]
      @load_seed_data = options[:seed]

      unless @run_migrations
         @load_seed_data = false
      end
    end

    def remove_unneeded_files
      remove_file "public/index.html"
    end

    def clear_logs
      remove_file 'log/sidekiq.log'
      add_file 'log/sidekiq.log'
    end

    def add_files
      template 'config/sidekiq.yml', 'config/sidekiq.yml'
      template 'Procfile', 'Procfile'
    end

    def setup_assets
      @lib_name = 'gaku'
      %w{javascripts stylesheets images}.each do |path|
        empty_directory "app/assets/#{path}/gaku"
      end

      template "app/assets/javascripts/gaku/all.js"
      template "app/assets/stylesheets/gaku/all.css"
    end

    def create_overrides_directory
      empty_directory "app/overrides"
    end

    def configure_application
      application <<-APP

    config.to_prepare do
      # Load application's model / class injectors
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_injector*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      # Load application's view overrides
      Dir.glob(File.join(File.dirname(__FILE__), "../app/overrides/*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
      APP

      append_file "config/environment.rb", "\nActiveRecord::Base.include_root_in_json = true\n"
    end

    def include_seed_data
      append_file "db/seeds.rb", <<-SEEDS
\n
Gaku::Core::Engine.load_seed if defined?(Gaku::Core)
      SEEDS
    end

    def install_migrations
      say_status :copying, "migrations"
      silence_stream(STDOUT) do
        silence_warnings { rake 'railties:install:migrations' }
      end
    end

    def create_database
      say_status :creating, "database"
      silence_stream(STDOUT) do
        silence_stream(STDERR) do
          silence_warnings { rake 'db:create', env: @env }
        end
      end
    end

    def run_migrations
      if @run_migrations
        say_status :running, "migrations"
        rake 'db:migrate', env: @env
      else
        say_status :skipping, "migrations (don't forget to run rake db:migrate)"
      end
    end

    def populate_seed_data
      if @load_seed_data
        say_status :loading,  "seed data"
        rake_options=[]
        rake_options << "RAILS_ENV=#{@env}"
        rake_options << "AUTO_ACCEPT=1" if options[:auto_accept]

        cmd = lambda { rake("db:seed #{rake_options.join(' ')}") }
        if options[:auto_accept] || (options[:admin_email] && options[:admin_password])
          quietly &cmd
        else
          cmd.call
        end
      else
        say_status :skipping, "seed data (you can always run rake db:seed)"
      end
    end

    def notify_about_routes
      insert_into_file File.join('config', 'routes.rb'), after: "Application.routes.draw do\n" do
        %Q{
  # This line mounts Gaku's routes at the root of your application.
  # This means, any requests to URLs such as /students, will go to Gaku::StudentsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Gaku relies on it being the default of "gaku"

  mount Gaku::Core::Engine, at: '/'

        }
      end

      unless options[:quiet]
        puts "*" * 50
        puts "We added the following line to your application's config/routes.rb file:"
        puts " "
        puts "    mount Gaku::Core::Engine, at: '/'"
      end
    end

    def complete
      unless options[:quiet]
        puts "*" * 50
        puts "Gaku has been installed successfully. You're all ready to go!"
        puts " "
        puts "Enjoy!"
      end
    end

  end
end
