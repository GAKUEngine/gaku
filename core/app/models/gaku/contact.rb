module Gaku
  class Contact < ActiveRecord::Base
    belongs_to :contact_type
    belongs_to :student
    belongs_to :guardian
    belongs_to :campus

    attr_accessible :data, :details, :contact_type_id, :is_primary, :is_emergency

    validates_presence_of :data,:contact_type_id

    before_save :ensure_primary, :on => :create

    private

    def method_missing(method, *args, &block)
      if ['make_primary_campus','make_primary_guardian', 'make_primary_student'].include?(method.to_s)
        foreign_key_sym = (method.to_s.split('_').last + '_id').to_sym

        self.update_attributes(:is_primary => true)
        user_contacts = Contact.where(foreign_key_sym => self.send(foreign_key_sym))
        user_contacts.update_all('is_primary = false', "id <> #{self.id}")
      else
        super
      end
    end

    def ensure_primary
    	if self.student_id
    		user_contacts = Contact.where(:student_id => self.student_id)
  			user_contacts.blank? && (self.is_primary == false) ? self.is_primary=true : nil
    	elsif self.guardian_id
        user_contacts = Contact.where(:guardian_id => self.guardian_id)
        user_contacts.blank? && (self.is_primary == false) ? self.is_primary=true : nil
      end
    end

  end
end

