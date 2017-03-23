module Gaku
  module Api
    class Engine < ::Rails::Engine
      config.generators.api_only = true
    end
  end
end
