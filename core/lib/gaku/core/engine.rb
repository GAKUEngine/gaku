module Gaku
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Gaku
      engine_name 'gaku'

      config.autoload_paths += %W(#{config.root}/lib)



      config.generators do |g|
        g.test_framework :rspec, view_specs: false
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

      require 'gaku/core/routes'

    end
  end
end
