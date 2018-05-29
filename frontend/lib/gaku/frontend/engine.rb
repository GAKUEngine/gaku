module Gaku
  module Frontend
    class Engine < ::Rails::Engine
      engine_name 'gaku_frontend'

      config.autoload_paths += %W(#{config.root}/lib)

      config.to_prepare do
        # Gaku::GakuController.helper(Gaku::FrontendHelper)
      end

      config.after_initialize do
        Rails.application.routes_reloader.reload!
      end

      # sets the manifests / assets to be precompiled, even when initialize_on_precompile is false
      initializer 'gaku.assets.precompile', group: :all do |app|
        app.config.assets.precompile += %w(
          gaku/frontend/all*
        )
      end

      # filter sensitive information during logging
      initializer 'gaku.params.filter' do |app|
        app.config.filter_parameters += [:password, :password_confirmation, :number]
      end

    end
  end
end
