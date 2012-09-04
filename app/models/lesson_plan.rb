class LessonPlan < ActiveRecord::Base
	has_many :lessons
	has_many :notes
	
	attr_accessible :title, :description
end