module Gaku
  class StudentAddress < ActiveRecord::Base

    include Trashable

  	belongs_to :student
    belongs_to :address

    attr_accessible :student_id, :address_id, :is_primary, :is_deleted

    before_save :ensure_primary, :on => :create
    
    def ensure_primary
      if self.student.addresses.blank?
        self.is_primary = true
      end
    end

    def make_primary
      # raise self.student.student_addresses.inspect
    	self.student.student_addresses.update_all("is_primary = 'f'", "id <> #{self.id}")
    	self.is_primary = true
    	self.save
    end

  end
end
