module Gaku
  class Contact < ActiveRecord::Base

    belongs_to :contact_type
    belongs_to :contactable, polymorphic: true, counter_cache: true

    has_paper_trail class_name: 'Gaku::Versioning::ContactVersion',
                    on: [:update, :destroy],
                    meta: {
                            join_model: :join_model_name,
                            joined_resource_id: :joined_resource_id
                          }

    validates :data, :contact_type, presence: true

    before_save :ensure_first_is_primary, on: :create
    before_save :remove_other_primary
    after_save :update_primary_contact_field

    delegate :name, to: :contact_type, allow_nil: true

    default_scope -> { where(deleted: false) }

    def soft_delete
      update_attributes(deleted: true, primary: false)
      decrement_count
    end

    def recover
      update_attribute(:deleted, false)
      increment_count
    end

    def self.deleted
      where(deleted: true)
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

    def join_model_name
      contactable_type
    end

    def joined_resource_id
      contactable_id
    end

    private

    def increment_count
      contactable.class.increment_counter(:addresses_count, contactable.id)
    end

    def decrement_count
      contactable.class.decrement_counter(:addresses_count, contactable.id)
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

