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
        remove_other_primary if @contact.contactable.respond_to?(:contacts)
        return true
      else
        @errors = @contact.errors
        return false
      end
    end

    def save!
      if save
        @contact
      else
        raise 'Failed to save record'
      end
    end

    private

    def ensure_first_is_primary
      @contact.primary = true if @contact.contactable.respond_to?(:contacts) && @contact.contactable.contacts.blank?
    end

    def remove_other_primary
      @contact.contactable.reload.contacts.where.not(id: @contact.id).update_all(primary: false) if @contact.primary?
    end

    # Workaround performance issue by not using JOIN
  end
end
