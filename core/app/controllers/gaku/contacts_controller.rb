module Gaku
  class ContactsController < GakuController

    load_and_authorize_resource :contact, :class => Gaku::Contact

    inherit_resources
    respond_to :js, :html

    before_filter :contactable
    before_filter :count

    def create
      @contact = @contactable.contacts.new(params[:contact])
      create!
    end

    def destroy
      if @contact.destroy
        if @contact.is_primary?
          @contactable.contacts.first.try(:make_primary)
        end
      end
      flash.now[:notice] = t(:'notice.destroyed', :resource => t(:'contact.singular'))
      destroy!
    end

    def make_primary
      @contact.make_primary
      respond_with @contact
    end

    def create_modal
      #extra action because of modal guardian contact creating form student#show
      if @contactable.class == Gaku::Guardian
        @contact = @contactable.contacts.build(params[:contact])
        if @contact.save
          flash.now[:notice] = t(:'notice.created', :resource => t(:'contact.singular'))
          respond_with(@contact)
        end
      end
    end

    private

    def count
      @count = @contactable.contacts.count
    end

    def contactable
      klasses = [Gaku::School, Gaku::Student, Gaku::Campus, Gaku::Guardian].select do |c|
        params[c.to_s.foreign_key]
      end

      @nested_resources = nested_resources(klasses)
      @resource_name = resource_name
      # raise @resource_name.inspect
    end

    def nested_resources(klasses)
      nested_resources = Array.new
      if klasses.is_a? Array
        @contactable = klasses.last.find(params[klasses.last.to_s.foreign_key])

        klasses.pop #remove @contactable resource
        klasses.each do |klass|
          nested_resources.append klass.find(params[klasses.last.to_s.foreign_key])
        end
      else
        @contactable = klasses.find(params[klasses.to_s.foreign_key])
      end

      #prepend :admin for admin/namespacing
      nested_resources.prepend(:admin) if @contactable.class == Gaku::Campus
      return nested_resources
    end

    def resource_name
      resource_name = Array.new
      @nested_resources.each do |resource|
        resource.is_a?(Symbol) ? resource_name.append(resource.to_s) : resource_name.append(get_class(resource))
      end
      resource_name.append get_class(@contactable)
      resource_name.append get_class(@contact)
      resource_name.join '-'
    end

    def get_class(object)
      object.class.to_s.underscore.dasherize.split('/').last
    end


  end
end