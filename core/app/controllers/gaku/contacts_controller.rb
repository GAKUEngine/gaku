module Gaku
  class ContactsController < GakuController

    #load_and_authorize_resource :contact, class: Gaku::Contact

    include PolymorphicResourceConcern

    respond_to :js, :html

    before_action :set_contact_types
    before_action :set_unscoped_contact, only: %i( recovery destroy )
    before_action :set_contact,          only: %i( edit update soft_delete make_primary )
    before_action :set_polymorphic_resource

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
      flash.now[:notice] = t(:'notice.destroyed', resource: t_resource)
      set_count
      respond_with @contact
    end

    def recovery
      @contact.recover
      flash.now[:notice] = t(:'notice.recovered', resource: t_resource)
      respond_with @contact
    end

    def soft_delete
      @primary_contact = true if @contact.primary?
      @contact.soft_delete
      @polymorphic_resource.contacts.first.try(:make_primary) if @contact.primary?
      flash.now[:notice] = t(:'notice.destroyed', resource: t_resource)
      set_count
      respond_with @contact
    end

    def make_primary
      @contact.make_primary
      respond_with @contact
    end

    private

    def set_unscoped_contact
      @contact = Contact.unscoped.find(params[:id])
    end

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(attributes)
    end

    def attributes
      %i(data details contact_type_id primary emergency)
    end

    def t_resource
      t(:'contact.singular')
    end

    def resource_klass
      'contact'
    end

    def polymorphic_klasses
      [Gaku::School, Gaku::Campus, Gaku::Student, Gaku::Guardian, Gaku::Teacher]
    end

    def set_contact_types
      @contact_types = ContactType.all.map { |ct| [ct.name, ct.id] }
    end

    def set_count
      @count = @polymorphic_resource.reload.contacts_count
    end

  end
end
