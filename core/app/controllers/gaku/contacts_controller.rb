module Gaku
  class ContactsController < GakuController

    #load_and_authorize_resource :contact, class: Gaku::Contact

    respond_to :js, :html

    before_action :set_contact_types
    before_action :set_unscoped_contact, only: %i( recovery destroy )
    before_action :set_contact,          only: %i( edit update soft_delete )

    def new
      @contact = Contact.new
      contactable
      respond_with @contact
    end

    def create
      contactable
      @contact = @contactable.contacts.new(contact_params)
      @contact.save
      set_count
      respond_with @contact
    end

    def edit
      contactable
    end

    def update
      @contact.update(contact_params)
      contactable
      respond_with @contact
    end

    def destroy
      contactable
      if @contact.destroy
        @contactable.contacts.first.try(:make_primary) if @contact.primary?
      end
      flash.now[:notice] = t(:'notice.destroyed', resource: t_resource)
      set_count
      respond_with @contact
    end

    def recovery
      @contact.recover
      contactable
      flash.now[:notice] = t(:'notice.recovered', resource: t_resource)
      respond_with @contact
    end

    def soft_delete
      @primary_contact = true if @contact.primary?
      @contact.soft_delete
      contactable
      @contactable.contacts.first.try(:make_primary) if @contact.primary?
      flash.now[:notice] = t(:'notice.destroyed', resource: t_resource)
      set_count
      respond_with @contact
    end

    def make_primary
      @contact.make_primary
      contactable
      respond_with @contact
    end

    protected

    def set_unscoped_contact
      @contact = Contact.unscoped.find(params[:id])
    end

    def set_contact
      @contact = Contact.find(params[:id])
    end

    private

    def contact_params
      params.require(:contact).permit(attributes)
    end

    def attributes
      %i(data details contact_type_id primary emergency)
    end

    def t_resource
      t(:'contact.singular')
    end

    def set_contact_types
      @contact_types = ContactType.all.map { |ct| [ct.name, ct.id] }
    end

    def set_count
      @count = @contactable.reload.contacts_count
    end

    def contactable_klasses
      [Gaku::School, Gaku::Campus, Gaku::Student, Gaku::Guardian, Gaku::Teacher]
    end

    def contactable
      klasses = contactable_klasses.select do |c|
        params[c.to_s.foreign_key]
      end

      @nested_resources = nested_resources(klasses)
      @resource_name = resource_name
    end

    def nested_resources(klasses)
      nested_resources = []
      last_klass_foreign_key = params[klasses.last.to_s.foreign_key]
      if klasses.is_a? Array
        @contactable = klasses.last.find(last_klass_foreign_key)

        klasses.pop #remove @contactable resource
        klasses.each do |klass|
          nested_resources.append klass.find(params[klass.to_s.foreign_key])
        end
      else
        @contactable = klasses.find(params[klasses.to_s.foreign_key])
      end

      #prepend :admin for admin/namespacing
      nested_resources.prepend(:admin) if @contactable.class == Gaku::Campus
      return nested_resources
    end

    def resource_name
      resource_name = []
      @nested_resources.each do |resource|
        if resource.is_a?(Symbol)
          resource_name.append(resource.to_s)
        else
          resource_name.append(get_class(resource))
        end
      end
      resource_name.append get_class(@contactable)
      resource_name.append get_class(@contact)
      resource_name.join '-'
    end

  end
end
