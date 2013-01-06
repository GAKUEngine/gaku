module Gaku
	class Campus < ActiveRecord::Base

		has_many :contacts
		belongs_to :school
		has_one :address

		attr_accessible :name, :school_id, :address_id, :is_master

		scope :master, lambda { where(:is_master => true) }

    validates_presence_of :name

	end
end
