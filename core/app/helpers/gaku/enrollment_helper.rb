module Gaku
  module EnrollmentHelper

    include ActionView::Helpers::TagHelper
    include ActionView::Context

    def msg_for_enrollment(student)
      "<p>#{student} : <span style='color:green;'> #{t(:'success.enrolled')}</span></p>"
    end


    def msg_for_failed_enrollment(student, errors)
      "<p>#{student} : <span style='color:orange;'> #{errors}</span></p>"
    end

  end
end
