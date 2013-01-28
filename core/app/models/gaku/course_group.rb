module Gaku
	class CourseGroup < ActiveRecord::Base

    include Trashable

	  has_many :course_group_enrollments
	  has_many :courses, :through => :course_group_enrollments

    attr_accessible :name

	  validates_presence_of :name

	end
end
