module Gaku
  module StudentChooserHelper

    def student_chooser_modal(&block)
      style = 'display: block;position: absolute;left: 500px;top: 100px;width:auto;height:auto;text-align:center;'
      content_tag :div, class: 'modal hide', id: 'student-modal', wmode: 'opaque', style: style do
        block.call
      end
    end

  end
end
