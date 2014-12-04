module Gaku
  class ContactUpdation
    attr_reader :contact, :errors

    def initialize(contact)
      @contact = contact
      @errors  = []
    end

    def update(params)
      @contact.assign_attributes(params)

      if @contact.save
        if @contact.contactable.respond_to?(:contacts)
          remove_other_primary
          # update_primary_contact_field
        end
        true
      else
        @errors = @contact.errors
        false
      end
    end

    private

    def remove_other_primary
      if @contact.primary?
        @contact.contactable.reload.contacts.where.not(id: @contact.id).update_all(primary: false)
      end
    end

    # Workaround performance issue by not using JOIN
    # def update_primary_contact_field
    #   if @contact.contactable.has_attribute?(:primary_contact)
    #     @contact.contactable.update_column(:primary_contact, @contact.contactable.contact_widget)
    #   end
    # end

  end
end
