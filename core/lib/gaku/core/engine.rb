module Gaku
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Gaku
      engine_name 'gaku'

      config.autoload_paths += %W( #{config.root}/lib )

      initializer 'gaku.paperclip' do
        Paperclip.interpolates(:placeholder) do |_attachment, style|
          ActionController::Base.helpers.asset_path("missing_#{style}.png")
        end
      end

      initializer 'gaku.ruby_template_handler' do
        ActionView::Template.register_template_handler(:rb, :source.to_proc)
      end

      initializer 'gaku.mime_types' do
        Mime::Type.register 'application/xls', :xls
      end

      config.after_initialize do
        Rails.application.routes_reloader.reload!
      end

    end
  end
end
