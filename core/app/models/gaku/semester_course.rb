module Gaku
  class SemesterCourse < ActiveRecord::Base
    belongs_to :semester
    belongs_to :course

    validates_presence_of :semester_id, :course_id


    def self.group_by_semester
      all(include: [:semester, :course]).group_by(&:semester_id)
    end
  end
end
