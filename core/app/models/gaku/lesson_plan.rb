module Gaku
	class LessonPlan < ActiveRecord::Base

    include Notable

		has_many :lessons
	  has_many :attachments, :as => :attachable
		belongs_to :syllabus

		attr_accessible :title, :description
    
	end
end
