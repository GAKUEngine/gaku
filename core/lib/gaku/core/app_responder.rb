module Gaku
  module Core
    class AppResponder < ActionController::Responder
      include Responders::FlashResponder
      include Responders::HttpCacheResponder
    end
  end
end