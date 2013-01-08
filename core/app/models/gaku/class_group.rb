module Gaku
	class ClassGroup < ActiveRecord::Base
	  has_many :class_group_enrollments
	  has_many :students, :through => :class_group_enrollments

	  has_many :class_group_course_enrollments, :dependent => :destroy
	  has_many :courses, :through => :class_group_course_enrollments

	  has_many :semesters
	  has_many :notes, as: :notable

	  attr_accessible :name, :grade, :homeroom

	  validates_presence_of :name
	end
end
