module Gaku
	class Campus < ActiveRecord::Base

    include Contacts, Picture

    belongs_to :school
    has_one :address, as: :addressable

		attr_accessible :name, :school_id, :is_master

    validates_presence_of :name

    scope :master, lambda { where(:is_master => true) }


   after_destroy :refresh_address_count

   private

   def refresh_address_count
     Campus.reset_counters(self.id, :addresses)
   end

  end
end
