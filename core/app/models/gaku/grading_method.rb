module Gaku
	class GradingMethod < ActiveRecord::Base
		has_one :exam
	  has_one :exam_portion
	  has_one :assignment

	  attr_accessible :description, :method, :name
	end
end
