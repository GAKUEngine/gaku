module Gaku
	class GradingMethod < ActiveRecord::Base
		has_one :exam
	  has_one :exam_portion
	  has_one :assignment

    has_many :grading_method_set_items
    has_many :grading_method_sets, through: :grading_method_set_items

	  attr_accessible :description, :method, :name, :curved, :arguments
    validates :name, :presence => true
	end
end
