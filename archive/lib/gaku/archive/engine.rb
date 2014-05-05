module Gaku
  module Archive
    class Engine < ::Rails::Engine
      engine_name 'gaku_archive'

      config.autoload_paths += %W(#{config.root}/lib)

      def self.activate
        Dir.glob(File.join(File.dirname(__FILE__), '../../../app/**/*_injector*.rb')) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
      end

      config.to_prepare &method(:activate).to_proc

      config.after_initialize do
        Rails.application.routes_reloader.reload!
      end

    end
  end
end
