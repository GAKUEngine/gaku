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
      paths = superclass.source_paths
      paths << File.expand_path('../templates', "../../#{__FILE__}")
      paths << File.expand_path('../templates', "../#{__FILE__}")
      paths << File.expand_path('../templates', __FILE__)
      paths.flatten
    end

    def prepare_options
      @env = options[:env]
      @run_migrations = options[:migrate]
      @load_seed_data = options[:seed]

      @load_seed_data = false unless @run_migrations
    end

    def remove_unneeded_files
      remove_file 'public/index.html'
    end

    def setup_assets
      @lib_name = 'gaku'
      %w( javascripts stylesheets images ).each do |path|
        empty_directory "app/assets/#{path}/gaku/frontend" if defined? Gaku::Frontend || Rails.env.test?
        empty_directory "app/assets/#{path}/gaku/admin" if defined? Gaku::Admin || Rails.env.test?
      end

      if defined? Gaku::Frontend || Rails.env.test?
        template 'app/assets/javascripts/gaku/frontend/all.js'
        template 'app/assets/stylesheets/gaku/frontend/all.css'
      end

      if defined? Gaku::Admin || Rails.env.test?
        template 'app/assets/javascripts/gaku/admin/all.js'
        template 'app/assets/stylesheets/gaku/admin/all.css'
      end
    end

    def create_overrides_directory
      empty_directory 'app/overrides'
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

      # Load application's services
      Dir.glob(File.join(File.dirname(__FILE__), "../app/services/**/*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
      APP

      append_file 'config/environment.rb', "\nActiveRecord::Base.include_root_in_json = true\n"
    end

    def include_seed_data
      append_file 'db/seeds.rb', <<-SEEDS
\n
Gaku::Core::Engine.load_seed if defined?(Gaku::Core)
      SEEDS
    end

    def install_migrations
      say_status :copying, 'migrations'
      silence_stream(STDOUT) do
        silence_warnings { rake 'railties:install:migrations' }
      end
    end

    def create_database
      say_status :creating, 'database'
      silence_stream(STDOUT) do
        silence_stream(STDERR) do
          silence_warnings { rake 'db:create', env: @env }
        end
      end
    end

    def run_migrations
      if @run_migrations
        say_status :running, 'migrations'
        rake 'db:migrate', env: @env
      else
        say_status :skipping, "migrations (don't forget to run rake db:migrate)"
      end
    end

    def populate_seed_data
      if @load_seed_data
        say_status :loading,  'seed data'
        cmd = lambda { rake 'db:seed', env: @env }
        cmd.call
      else
        say_status :skipping, 'seed data (you can always run rake db:seed)'
      end
    end

    def notify_about_routes
      if File.readlines(File.join('config', 'routes.rb')).grep(/mount Gaku::Core::Engine/).any?
        say_status :skipping, 'route Gaku::Core::Engine already present.'
      else
        insert_into_file File.join('config', 'routes.rb'), after: "Rails.application.routes.draw do\n" do
          %Q( mount Gaku::Core::Engine, at: '/' )
        end

        unless options[:quiet]
          puts '*' * 50
          puts "We added the following line to your application's config/routes.rb file:"
          puts ' '
          puts "    mount Gaku::Core::Engine, at: '/'"
        end
      end
    end

    def complete
      unless options[:quiet]
        puts '*' * 50
        puts "Gaku has been installed successfully. You're all ready to go!"
        puts ' '
        puts 'Enjoy!'
      end
    end

  end
end
