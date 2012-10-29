module Gaku
  module Core
    module UrlHelpers
      def gaku
        Gaku::Core::Engine.routes.url_helpers
      end
    end
  end
end