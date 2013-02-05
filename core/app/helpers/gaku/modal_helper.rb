module Gaku
  module ModalHelper

    def close_button
      content_tag :button, :class => 'close', :'data-dismiss' => 'modal' do
        "&times".html_safe
      end
    end

    def modal_for(id, &block)
      content_tag :div, class: "modal hide", id: id, wmode: "opaque" do
        block.call
      end
    end

    def modal_body(&block)
      content_tag :div, class: "modal-body" do
        content_tag :div, class: "row-fluid" do
          content_tag :div, class: "span12 well" do
            block.call
          end
        end
      end
    end

    def modal_header(text)
      content_tag :div, class: "modal-header" do
        concat close_button
        concat content_tag(:h3) { text }
      end
    end

    def student_chooser_modal(&block)
      style = "display: block;position: absolute;left: 500px;top: 100px;width:auto;height:auto;text-align:center;"
      content_tag :div, class: "modal hide", id: "student-modal", wmode: "opaque", style: style do
        block.call
      end
    end

  end
end
