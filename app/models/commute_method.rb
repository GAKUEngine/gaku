class CommuteMethod < ActiveRecord::Base
	has_one :student
	belongs_to :commute_method_type
end