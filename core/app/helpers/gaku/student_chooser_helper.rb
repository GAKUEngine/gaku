module Gaku
  module StudentChooserHelper

    def student_chooser_modal(&block)
      modal_for 'student-modal' do
        block.call
      end
    end

  end
end
