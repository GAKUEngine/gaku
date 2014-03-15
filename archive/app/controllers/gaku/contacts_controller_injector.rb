module Gaku
  ContactsController.class_eval do

    def recovery
      @contact = Contact.deleted.find(params[:id])
      @contact.recover
      respond_with @contact
    end

    def soft_delete
      set_polymorphic_resource
      @contact = Contact.find(params[:id])
      @primary_contact = true if @contact.primary?
      @contact.soft_delete
      @polymorphic_resource.contacts.first.try(:make_primary) if @contact.primary?
      @count = @polymorphic_resource.reload.contacts_count
      respond_with @contact
    end

  end
end
