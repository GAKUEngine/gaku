module Gaku
	class ExamScore < ActiveRecord::Base
	  belongs_to :exam
	  attr_accessible :score, :comment

	  validates :score, :numericality => { :greater_than_or_equal_to => 0 }, :presence => true
	end
end
