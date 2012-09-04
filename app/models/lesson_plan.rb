class LessonPlan < ActiveRecord::Base
	has_many :lessons
	
	attr_accessible :title, :description
end