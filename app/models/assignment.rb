class Assignment < ActiveRecord::Base
	belongs_to :syllabus

	attr_accessible :name, :description, :max_score, :syllabus_id
end