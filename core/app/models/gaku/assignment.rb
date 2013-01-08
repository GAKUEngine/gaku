module Gaku
	class Assignment < ActiveRecord::Base
		belongs_to :syllabus
		belongs_to :grading_method

		attr_accessible :name, :description, :max_score, :syllabus_id, :grading_method_id

    validates_presence_of :name
    validates_associated :syllabus, :grading_method
	end
end
