module Gaku
  module AdminHelper

    include Gaku::PresetsHelper
    include Gaku::SharedHelper

    def nested_header(text)
      content_tag :h4, text
    end

    def grading_methods_with_i18n
      grading_methods = Gaku::GradingMethod.method_list.keys
      Hash[*grading_methods.map do |k|
        [I18n.t("grading_method.#{k}"), k.to_s]
      end.flatten]

    end

    def badge_count(count, text, css_class)
      if count != 0
        "#{text}<span class='badge pull-right #{css_class}'>#{count}</span>".html_safe
      else
        "#{text}<span class='badge pull-right #{css_class}'></span>".html_safe
      end
    end

  end
end
