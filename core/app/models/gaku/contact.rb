module Gaku
  class Contact < ActiveRecord::Base
    belongs_to :contact_type
    belongs_to :contactable, polymorphic: true, counter_cache: true

    validates :data, :contact_type, presence: true

    before_save :ensure_first_is_primary, on: :create
    before_save :remove_other_primary
    after_save :update_primary_contact_field

    delegate :name, to: :contact_type, allow_nil: true

    def to_s
      data
    end

    def self.primary_email
      where(primary: true, contact_type: Gaku::ContactType.where(name: 'Email').first).first
    end

    def self.students
      where(contactable_type: Gaku::Student)
    end

    def self.teachers
      where(contactable_type: Gaku::Teacher)
    end

    def self.guardians
      where(contactable_type: Gaku::Guardian)
    end

    def make_primary
      contacts.where.not(id: id).update_all(primary: false)
      update_attribute(:primary, true)

      if contactable.has_attribute?(:primary_contact)
        contactable.update_attribute(:primary_contact, contact_widget)
      end
    end

    def primary?
      primary
    end

    def self.primary
      where(primary: true).first
    end

    def self.secondary
      where(primary: false)
    end

    private

    def increment_count
      contactable.class.increment_counter(:contacts_count, contactable.id)
    end

    def decrement_count
      contactable.class.decrement_counter(:contacts_count, contactable.id)
    end

    def remove_other_primary
      contacts.where.not(id: id).update_all(primary: false) if primary?
    end

    def ensure_first_is_primary
      if contactable.respond_to? :contacts
        self.primary = true if contacts.blank?
      end
    end

    def contact_widget
      contactable.contact_widget
    end

    def update_primary_contact_field
      if contactable.has_attribute? :primary_contact
        contactable.update_attribute(:primary_contact, contactable.contact_widget)
      end
    end

    def contacts
      contactable.contacts
    end
  end
end
