module Gaku
	class CommuteMethod < ActiveRecord::Base
		has_one :student
		belongs_to :commute_method_type

		attr_accessible :commute_method_type_id

    validates :commute_method_type_id, presence: true

    def to_s
      self.commute_method_type.name
    end

	end
end
