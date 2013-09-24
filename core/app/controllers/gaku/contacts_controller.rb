module Gaku
  class ContactsController < GakuController

    load_and_authorize_resource :contact, class: Gaku::Contact

    inherit_resources
    respond_to :js, :html

    before_filter :contactable
    before_filter :count
    before_filter :load_data

    def create
      @contact = @contactable.contacts.new(contact_params)
      create!
    end

    def destroy
      if @contact.destroy
        @contactable.contacts.first.try(:make_primary) if @contact.primary?
      end
      flash.now[:notice] = t(:'notice.destroyed', resource: t_resource)
      destroy!
    end

    def recovery
      @contact.recover
      flash.now[:notice] = t(:'notice.recovered', resource: t_resource)
      respond_with @contact
    end

    def soft_delete
      @primary_contact = true if @contact.primary?
      @contact.soft_delete
      @contactable.contacts.first.try(:make_primary) if @contact.primary?
      flash.now[:notice] = t(:'notice.destroyed', resource: t_resource)
      respond_with @contact
    end

    def make_primary
      @contact.make_primary
      respond_with @contact
    end

    def create_modal
      if @contactable.class == Gaku::Guardian
        @contact = @contactable.contacts.build(params[:contact])
        if @contact.save
          flash.now[:notice] = t(:'notice.created', resource: t_resource)
          respond_with @contact
        end
      end
    end

    protected

    def resource_params
      return [] if request.get?
      [params.require(:contact).permit(contact_attr)]
    end

    private

    def contact_params
      params.require(:contact).permit(contact_attr)
    end

    def contact_attr
      %i(data details contact_type_id primary emergency)
    end

    def t_resource
      t(:'contact.singular')
    end

    def load_data
      @contact_types = ContactType.all.map { |ct| [ct.name, ct.id] }
    end

    def count
      @count = @contactable.contacts_count
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
          nested_resources.append klass.find(last_klass_foreign_key)
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
