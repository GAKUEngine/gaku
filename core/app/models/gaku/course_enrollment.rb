module Gaku
  class CourseEnrollment < ActiveRecord::Base
    belongs_to :student, :counter_cache => :courses_count
    belongs_to :course

    validates :student_id, :uniqueness => {:scope => :course_id, :message => "Already enrolled to course!"}
    validates_presence_of :course_id

    attr_accessible :student_id, :course_id

  end
end
