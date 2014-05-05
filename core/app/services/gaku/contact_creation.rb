module Gaku
  class ContactCreation
    attr_reader :errors, :contact

    def initialize(params = {})
      @contact = Contact.new(params)
      @errors = []
    end

    def save
      ensure_first_is_primary

      if @contact.save
        if @contact.contactable.respond_to?(:contacts)
          remove_other_primary
          update_primary_contact_field
        end
        return true
      else
        @errors = @contact.errors
        return false
      end
    end

    def save!
      if save
        return @contact
      else
        fail 'Failed to save record'
      end
    end

    private

    def ensure_first_is_primary
      if @contact.contactable.respond_to?(:contacts) && @contact.contactable.contacts.blank?
        @contact.primary = true
      end
    end

    def remove_other_primary
      if @contact.primary?
        @contact.contactable.reload.contacts.where.not(id: @contact.id).update_all(primary: false)
      end
    end

    # Workaround performance issue by not using JOIN
    def update_primary_contact_field
      if @contact.contactable.has_attribute?(:primary_contact)
        @contact.contactable.update_column(:primary_contact, @contact.contactable.contact_widget)
      end
    end

  end
end
