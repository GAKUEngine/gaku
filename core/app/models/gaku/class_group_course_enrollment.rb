module Gaku
  class ClassGroupCourseEnrollment < ActiveRecord::Base
    belongs_to :class_group
    belongs_to :course

    validates :class_group_id, presence: true

    validates :course_id,
              presence: true,
              uniqueness: {
                scope: :class_group_id,
                message: I18n.t(:'class_group.already_enrolled')
              }
  end
end
