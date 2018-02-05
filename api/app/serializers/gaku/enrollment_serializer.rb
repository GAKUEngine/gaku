module Gaku
  class EnrollmentSerializer < ActiveModel::Serializer
    attributes %i( id student_id seat_number )
    attribute :course_id, if: :course_enrollment?

    def course_id
      object.enrollable_id
    end

    def course_enrollment?
      object.course_type?
    end
  end
end
