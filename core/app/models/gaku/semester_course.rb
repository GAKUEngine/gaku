module Gaku
  class SemesterCourse < ActiveRecord::Base
    belongs_to :semester
    belongs_to :course

    validates :course_id, presence: true

    validates :semester_id,
              presence: true,
              uniqueness: {
                scope: :course_id,
                message: I18n.t(:'semester_course.uniqueness')
              }

    def self.group_by_semester
      all.includes([:semester, :course]).group_by(&:semester_id)
    end
  end
end
