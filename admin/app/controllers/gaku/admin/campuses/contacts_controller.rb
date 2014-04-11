module Gaku
  class Admin::Campuses::ContactsController < Admin::BaseController

    respond_to :js

    before_action :set_contact_types,    only: %i( new edit )
    before_action :set_contact,          only: %i( edit update destroy make_primary )
    before_action :set_campus

    def new
      @contact = Contact.new
      respond_with @contact
    end

    def create
      @contact = @campus.contacts.new(contact_params)
      @contact.save
      set_count
      respond_with @contact
    end

    def edit
      respond_with @contact
    end

    def update
      @contact.update(contact_params)
      respond_with @contact
    end

    def destroy
      if @contact.destroy
        @campus.contacts.first.try(:make_primary) if @contact.primary?
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

    def set_campus
      @campus = Campus.find(params[:campus_id])
    end

    def contact_params
      params.require(:contact).permit(attributes)
    end

    def attributes
      %i( data details contact_type_id primary emergency )
    end

    def set_contact_types
      @contact_types = ContactType.all
    end

    def set_count
      @count = @campus.reload.contacts_count
    end

  end
end
