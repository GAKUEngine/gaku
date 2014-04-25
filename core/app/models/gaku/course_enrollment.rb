module Gaku
  class CourseEnrollment < ActiveRecord::Base
    belongs_to :student, counter_cache: :courses_count
    belongs_to :course,  counter_cache: :students_count

    validates :course_id, presence: true

    validates :student_id,
              presence: true,
              uniqueness: {
                scope: :course_id,
                message: I18n.t(:'course.already_enrolled')
              }
    def code_with_syllabus_name
      course.decorate.code_with_syllabus_name if course
    end

    def course_id
      course.id if course
    end
  end
end
