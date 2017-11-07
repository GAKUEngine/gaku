require 'rails/generators'
require 'highline/import'
require 'bundler'
require 'bundler/cli'

module Gaku
  class DockerGenerator < Rails::Generators::Base

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

    def copy_database_yml
      copy_file 'config/database.yml', 'config/database.yml'
    end

    def copy_wait_bin
      copy_file 'bin/check_postgres.sh', 'bin/check_postgres.sh'
      chmod "bin/check_postgres.sh", 0755
    end

    def add_route
      route "mount Gaku::Core::Engine, at: '/'"
    end

    def install_migrations
      say_status :copying, 'migrations'
      rake 'railties:install:migrations'
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

  end
end
