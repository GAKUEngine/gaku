module Gaku
  module AdminHelper

    include Gaku::PresetsHelper
    include Gaku::SharedHelper

    def nested_header(text)
      content_tag :h4, text
    end

    def badge_count(count, text, css_class)
      if count != 0
        "#{text}<span class='badge pull-right #{css_class}'>#{count.to_s}</span>".html_safe
      else
        "#{text}<span class='badge pull-right #{css_class}'></span>".html_safe
      end
    end

  end
end