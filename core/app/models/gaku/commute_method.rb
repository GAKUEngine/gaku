module Gaku
	class CommuteMethod < ActiveRecord::Base
		has_one :student
		belongs_to :commute_method_type

		attr_accessible :commute_method_type_id

    def to_s
      self.commute_method_type
    end

	end
end
