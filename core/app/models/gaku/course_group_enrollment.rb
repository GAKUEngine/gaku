module Gaku
	class CourseGroupEnrollment < ActiveRecord::Base
	  belongs_to :course
	  belongs_to :course_group

	  attr_accessible :course_id, :course_group_id

	  validates_presence_of :course_group_id, :course_id
	  validates :course_id, :uniqueness =>
                                      {:scope => :course_group_id, :message => "Already enrolled to this course group!"}

	end
end
