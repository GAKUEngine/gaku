module Gaku
  class Enrollment < ActiveRecord::Base

    belongs_to :student
    belongs_to :enrollmentable, polymorphic: true

    validates :enrollmentable_type, :enrollmentable_id, :student_id, presence: true

    validates :student_id,
       uniqueness: {
                     scope: [ :enrollmentable_type, :enrollmentable_id ],
                     message: I18n.t(:'student.already_enrolled')
                   }

    validates :enrollmentable_type,
      inclusion: {
        in: %w(Gaku::Course Gaku::ClassGroup Gaku::ExtracurricularActivity),
        message: "%{value} is not a valid"
      }

  end
end
