module Gaku
  class SemesterCourse < ActiveRecord::Base
    belongs_to :semester
    belongs_to :course

    validates_presence_of :semester_id, :course_id
  end
end
