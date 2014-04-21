module Gaku
  class CourseGroup < ActiveRecord::Base
    has_many :course_group_enrollments
    has_many :courses, through: :course_group_enrollments

    validates :name, presence: true

    def to_s
      name
    end
  end
end
