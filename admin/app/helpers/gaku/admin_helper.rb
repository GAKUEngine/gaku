module Gaku
  module AdminHelper

    include Gaku::PresetsHelper
    include Gaku::SharedHelper

    def nested_header(text)
      content_tag :h4, text
    end

    def grading_methods_with_i18n
      grading_methods = Gaku::GradingMethodRouter.grading_methods.keys
      Hash[*grading_methods.map do |k|
        [I18n.t("grading_method.#{k}"), k.to_s]
      end.flatten]
    end

  end
end
