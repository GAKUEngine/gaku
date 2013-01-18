module Gaku
	class ExamPortionScore < ActiveRecord::Base
	  belongs_to :student
	  belongs_to :exam_portion

	  has_many :attendances, :as => :attendancable

	  attr_accessible :score, :exam_portion_id, :student_id, :entry_number
	end
end
