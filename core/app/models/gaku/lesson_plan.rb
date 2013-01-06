module Gaku
	class LessonPlan < ActiveRecord::Base
		has_many :lessons
		has_many :notes, as: :notable
	  has_many :attachments, :as => :attachable
		belongs_to :syllabus

		attr_accessible :title, :description
	end
end
