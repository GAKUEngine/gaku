module Gaku
  module AdminHelper

    include Gaku::PresetsHelper
    include Gaku::SharedHelper

    def nested_header(text)
      content_tag :h4, text
    end

  end
end