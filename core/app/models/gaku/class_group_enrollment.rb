module Gaku
  class ClassGroupEnrollment < ActiveRecord::Base

    belongs_to :class_group
    belongs_to :student
    has_many :roles

    # attr_accessible :seat_number, :roles, :class_group_id, :student_id

    validates :student_id,
              uniqueness: {
                            scope: :class_group_id,
                            message: I18n.t(:'class_group.already_enrolled')
                          }

    validates_presence_of :class_group_id, :student_id

    after_save :save_student_class_and_number

    private

    def save_student_class_and_number
      student.update_attribute(:class_and_number, class_and_number) if student
    end

    def class_and_number
      "#{class_group} - ##{seat_number}"
    end

  end
end
