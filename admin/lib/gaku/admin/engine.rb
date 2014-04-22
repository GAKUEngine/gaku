module Gaku
  module Admin
    class Engine < ::Rails::Engine
      engine_name 'gaku_admin'

      config.autoload_paths +=  %W(#{config.root}/lib)

      config.to_prepare do
        Gaku::Admin::BaseController.helper(Gaku::AdminHelper)
      end

      config.after_initialize do
        Rails.application.routes_reloader.reload!
      end

      # sets the manifests / assets to be precompiled, even when initialize_on_precompile is false
      initializer 'gaku.assets.precompile', group: :all do |app|
        app.config.assets.precompile += %w[
          gaku/admin/all*
        ]
      end

      # filter sensitive information during logging
      initializer 'gaku.params.filter' do |app|
        app.config.filter_parameters += %i( password password_confirmation number )
      end

    end
  end
end
