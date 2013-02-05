module Gaku
	class ClassGroup < ActiveRecord::Base

		include Notes

	  has_many :enrollments, class_name: "Gaku::ClassGroupEnrollment"
	  has_many :students, :through => :enrollments

	  has_many :class_group_course_enrollments, :dependent => :destroy
	  has_many :courses, :through => :class_group_course_enrollments

	  has_many :semesters

	  attr_accessible :name, :grade, :homeroom

	  validates_presence_of :name

	end
end
