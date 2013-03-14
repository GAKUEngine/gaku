module Gaku
	class GradingMethod < ActiveRecord::Base
		has_one :exam
	  has_one :exam_portion
	  has_one :assignment

	  attr_accessible :description, :method, :name
    validates :name, :presence => true
	end
end
