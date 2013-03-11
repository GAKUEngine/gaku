module Gaku
	class CommuteMethodType < ActiveRecord::Base

		has_many :students

    validates :name, presence: true, uniqueness: true

		attr_accessible :name

    def to_s
      name
    end

	end
end
