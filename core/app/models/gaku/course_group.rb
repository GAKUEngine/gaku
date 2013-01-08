module Gaku
	class CourseGroup < ActiveRecord::Base
	  attr_accessible :name

	  has_many :course_group_enrollments
	  has_many :courses, :through => :course_group_enrollments

	  validates_presence_of :name

	  default_scope :conditions => { :is_deleted => false }
	end
end
