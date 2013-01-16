module Gaku
  class Contact < ActiveRecord::Base
    belongs_to :contact_type

    belongs_to :contactable, polymorphic: true


    # has_paper_trail :on => [:update, :destroy],
                    # :meta => { :join_model  => :join_model_name, :joined_resource_id => :joined_resource_id }

    attr_accessible :data, :details, :contact_type_id, :is_primary, :is_emergency

    validates_presence_of :data,:contact_type_id

    before_save :ensure_first_primary, :on => :create

    def join_model_name
      'Gaku::Student' if self.student_id
    end

    def joined_resource_id
      self.student_id if self.student_id
    end

    def make_primary
      self.contactable.contacts.update_all(:is_primary => false)
      self.update_attribute(:is_primary, true)
    end

    def primary?
      if self.is_primary == true
        true
      else
        false
      end
    end

    private

    def ensure_first_primary
      self.is_primary = true if self.contactable.contacts.blank?
    end

  end
end

