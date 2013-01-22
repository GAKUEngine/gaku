module Gaku
	class CommuteMethodType < ActiveRecord::Base
		has_many :commute_methods

    validates :name, :presence => true, :uniqueness => true

		attr_accessible :name

    def self.type
      name
    end

	end
end
