module Gaku
  module Testing
    class Engine < ::Rails::Engine
      engine_name 'gaku_testing'

      config.autoload_paths += %W(#{config.root}/lib)

    end
  end
end
