module Gaku
	class Campus < ActiveRecord::Base

    include Contactable

    has_one :address, as: :addressable

    belongs_to :school

		attr_accessible :name, :school_id, :is_master

		scope :master, lambda { where(:is_master => true) }

    validates_presence_of :name

	end
end
