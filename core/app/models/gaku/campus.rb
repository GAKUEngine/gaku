module Gaku
	class Campus < ActiveRecord::Base

    include Contacts

    belongs_to :school
    has_one :address, as: :addressable

		attr_accessible :name, :school_id, :is_master

    validates_presence_of :name

    scope :master, lambda { where(:is_master => true) }

	end
end
