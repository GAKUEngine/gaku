module Gaku
	class Campus < ActiveRecord::Base

    has_one :address, as: :addressable
    has_many :contacts, as: :contactable

    belongs_to :school

		attr_accessible :name, :school_id, :address_id, :is_master

		scope :master, lambda { where(:is_master => true) }

    validates_presence_of :name

	end
end
