module Gaku
  module ModalHelper

    def close_button
      '<button class="close" data-dismiss="modal">&times;</button>'.html_safe
    end

    def modal_for(id, &block)
      content_tag :div, class: "modal hide", id: id, wmode: "opaque" do
        block.call
      end
    end

    def modal_header(text)
      content_tag :div, class: "modal-header" do
        close_button
        content_tag(:h3) {text}
      end
    end

  end
end
