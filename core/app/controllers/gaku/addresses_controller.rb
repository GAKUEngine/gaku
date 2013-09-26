module Gaku
  class AddressesController < GakuController

    load_and_authorize_resource :address,
                                class: Gaku::Address,
                                except: [:recovery, :destroy]

    inherit_resources

    respond_to :js, :html

    before_filter :load_data
    before_filter :unscoped_address, only: [:destroy, :recovery]
    before_filter :addressable
    before_filter :count

    def create
      @address = @addressable.addresses.new(address_params)
      create!
    end

    def make_primary
      @address.make_primary
      respond_with @address
    end

    def recovery
      @address.recover
      flash.now[:notice] = t(:'notice.recovered', resource: t_resource)
      respond_with @address
    end

    def soft_delete
      @primary_address = true if @address.primary?
      @address.soft_delete
      @addressable.addresses.first.try(:make_primary) if @address.primary?
      flash.now[:notice] = t(:'notice.destroyed', resource: t_resource)
      respond_with @address
    end

    protected

    def resource_params
      return [] if request.get?
      [params.require(:address).permit(address_attr)]
    end

    private

    def address_params
      params.require(:address).permit(address_attr)
    end

    def address_attr
      %i(title country_id state_id zipcode state_name city address1 address2)
    end


    def t_resource
      t(:'address.singular')
    end

    def addressable_klasses
      [Gaku::Student, Gaku::Campus, Gaku::Guardian, Gaku::Teacher]
    end

    def load_data
      @countries = Country.all.sort_by(&:name).map { |s| [s.name, s.id] }
    end

    def unscoped_address
      @address = Gaku::Address.unscoped.find(params[:id])
    end

    def count
      @count = @addressable.addresses_count
    end

    def addressable
      klasses = addressable_klasses.select do |c|
        params[c.to_s.foreign_key]
      end

      @nested_resources = nested_resources(klasses)
      @resource_name = resource_name
    end

    def nested_resources(klasses)
      nested_resources = []
      last_klass_foreign_key = params[klasses.last.to_s.foreign_key]
      if klasses.is_a? Array
        @addressable = klasses.last.find(last_klass_foreign_key)
        klasses.pop #remove @addressable resource
        klasses.each do |klass|
          nested_resources.append klass.find(params[klass.to_s.foreign_key])
        end
      else
        @addressable = klasses.find(params[klasses.to_s.foreign_key])
      end

      #prepend :admin for admin/namespacing
      nested_resources.prepend(:admin) if @addressable.class == Gaku::Campus
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
      resource_name.append get_class(@addressable)
      resource_name.append get_class(@address)
      resource_name.join '-'
    end

  end
end
