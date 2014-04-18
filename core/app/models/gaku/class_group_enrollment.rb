module Gaku
  class ClassGroupEnrollment < ActiveRecord::Base
    belongs_to :class_group
    belongs_to :student
    has_many :school_roles, as: :school_rolable

    validates :class_group, presence: true

    validates :student,
              presence: true,
              uniqueness: {
                scope: :class_group_id,
                message: I18n.t(:'class_group.already_enrolled')
              }

    after_save :save_student_class_and_number

    def class_and_number
      "#{class_group} - ##{seat_number}"
    end

    private

    def save_student_class_and_number
      student.update_attribute(:class_and_number, class_and_number) if student
    end
  end
end
