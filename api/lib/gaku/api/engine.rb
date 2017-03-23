module Gaku
  module Api
    class Engine < ::Rails::Engine
      engine_name 'gaku_api'
      config.generators.api_only = true
    end
  end
end
