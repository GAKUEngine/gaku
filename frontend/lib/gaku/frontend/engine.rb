module Gaku
  module Frontend
    class Engine < ::Rails::Engine
      engine_name 'gaku_frontend'

      config.autoload_paths += %W(#{config.root}/lib)

      config.generators do |g|
        g.test_framework :rspec, view_specs: false
      end

      config.to_prepare do
        Gaku::GakuController.helper(Gaku::FrontendHelper)
      end


      def self.activate
      end

      config.to_prepare &method(:activate).to_proc

      config.after_initialize do
      end

      # We need to reload the routes here due to how Gaku sets them up.
      # The different facets of Gaku  append/prepend routes to Core
      # *after* Core has been loaded.
      #
      # So we wait until after initialization is complete to do one final reload.
      # This then makes the appended/prepended routes available to the application.
      config.after_initialize do
        Rails.application.routes_reloader.reload!
      end

      # sets the manifests / assets to be precompiled, even when initialize_on_precompile is false
      initializer 'gaku.assets.precompile', group: :all do |app|
        app.config.assets.precompile += %w[
          gaku/frontend/all*
        ]
      end

      # filter sensitive information during logging
      initializer 'gaku.params.filter' do |app|
        app.config.filter_parameters += [:password, :password_confirmation, :number]
      end

    end
  end
end
