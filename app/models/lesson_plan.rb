class LessonPlan < ActiveRecord::Base
	has_many :lessons
	has_many :notes
	has_many :assets
	belongs_to :syllabus
	
	attr_accessible :title, :description
end