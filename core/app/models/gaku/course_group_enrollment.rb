module Gaku
  class CourseGroupEnrollment < ActiveRecord::Base
    belongs_to :course
    belongs_to :course_group

    validates :course_group_id, presence: true

    validates :course_id,
              presence: true,
              uniqueness: {
                scope: :course_group_id,
                message: I18n.t(:'course_group.already_enrolled')
              }
  end
end
