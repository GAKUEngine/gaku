module Gaku
  class CourseEnrollment < ActiveRecord::Base

    belongs_to :student, counter_cache: :courses_count
    belongs_to :course,  counter_cache: :students_count

    validates :student_id,
              uniqueness: {
                            scope: :course_id,
                            message: I18n.t(:'course.already_enrolled')
                          }

    validates :course_id, presence: true

  end
end
