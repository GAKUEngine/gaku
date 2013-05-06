module Gaku
  class ClassGroupCourseEnrollment < ActiveRecord::Base

    belongs_to :class_group
    belongs_to :course

    attr_accessible :class_group_id, :course_id

    validates :course_id,
              presence: true,
              uniqueness: {
                            scope: :class_group_id,
                            message: I18n.t(:'class_group.already_enrolled')
                          }


  end
end
