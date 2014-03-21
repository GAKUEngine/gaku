module Gaku
  class ContactsController < GakuController

    #load_and_authorize_resource :contact, class: Gaku::Contact

    include PolymorphicResourceConcern

    respond_to :js

    before_action :set_contact_types,    only: %i( new edit )
    before_action :set_contact,          only: %i( edit update destroy make_primary )
    before_action :set_polymorphic_resource

    def index
      @contacts = @polymorphic_resource.contacts
      respond_with @contacts
    end

    def new
      @contact = Contact.new
      respond_with @contact
    end

    def create
      @contact = @polymorphic_resource.contacts.new(contact_params)
      @contact.save
      set_count
      respond_with @contact
    end

    def edit
    end

    def update
      @contact.update(contact_params)
      respond_with @contact
    end

    def destroy
      if @contact.destroy
        @polymorphic_resource.contacts.first.try(:make_primary) if @contact.primary?
      end
      set_count
      respond_with @contact
    end


    def make_primary
      @contact.make_primary
      respond_with @contact
    end

    private

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(attributes)
    end

    def attributes
      %i( data details contact_type_id primary emergency )
    end

    def resource_klass
      'contact'
    end

    def polymorphic_klasses
      [Gaku::School, Gaku::Campus, Gaku::Student, Gaku::Guardian, Gaku::Teacher]
    end

    def set_contact_types
      @contact_types = ContactType.all
    end

    def set_count
      @count = @polymorphic_resource.reload.contacts_count
    end

  end
end
