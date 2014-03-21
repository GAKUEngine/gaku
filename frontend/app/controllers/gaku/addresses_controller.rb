module Gaku
  class AddressesController < GakuController

    include PolymorphicResourceConcern

    respond_to :js

    before_action :set_countries,        only: %i( new edit )
    before_action :set_unscoped_address, only: %i( recovery destroy )
    before_action :set_address,          only: %i( edit update soft_delete make_primary )
    before_action :set_polymorphic_resource

    def index
      @addresses = @polymorphic_resource.addresses
      respond_with @addresses
    end

    def new
      @address = Address.new
      respond_with @address
    end

    def create
      @address = @polymorphic_resource.addresses.new(address_params)
      @address.save
      set_count
      respond_with @address
    end

    def edit
    end

    def update
      @address.update(address_params)
      respond_with @address
    end

    def make_primary
      @address.make_primary
      respond_with @address
    end

    def recovery
      @address.recover
      respond_with @address
    end

    def destroy
      if @address.destroy
        @polymorphic_resource.addresses.first.try(:make_primary) if @address.primary?
      end
      set_count
      respond_with @address
    end

    def soft_delete
      @primary_address = true if @address.primary?
      @address.soft_delete
      @poymorphic_resource.addresses.first.try(:make_primary) if @address.primary?
      set_count
      respond_with @address
    end

    private

    def address_params
      params.require(:address).permit(attributes)
    end

    def attributes
      %i( title country_id state_id zipcode state_name city address1 address2 )
    end

    def resource_klass
      'address'
    end

    def polymorphic_klasses
      [Gaku::Student, Gaku::Campus, Gaku::Guardian, Gaku::Teacher]
    end

    def set_countries
      @countries = Country.all
    end

    def set_address
      @address = Address.find(params[:id])
    end

    def set_unscoped_address
      @address = Address.unscoped.find(params[:id])
    end

    def set_count
      @count = @polymorphic_resource.reload.addresses_count
    end

  end
end
