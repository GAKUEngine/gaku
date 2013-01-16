module Gaku
	class Syllabus < ActiveRecord::Base

		include Notes

	  has_many :courses
	  has_many :assignments
	  has_many :lesson_plans
	  has_many :exam_syllabuses
	  has_many :exams, :through => :exam_syllabuses

	  attr_accessible :name, :code, :description, :credits, :exams , :exams_attributes, :assignments, :assignments_attributes

	  accepts_nested_attributes_for :exams, :assignments

	  validates_presence_of :name, :code

	end
end


