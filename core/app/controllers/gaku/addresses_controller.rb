module Gaku
  class AddressesController < GakuController

    include PolymorphicResourceConcern

    # load_and_authorize_resource :address,
    #                             class: Gaku::Address,
    #                             except: [:recovery, :destroy]

    respond_to :js

    before_action :set_countries,        only: %i( new edit )
    before_action :set_unscoped_address, only: %i( recovery destroy )
    before_action :set_address,          only: %i( edit update soft_delete make_primary )
    before_action :set_polymorphic_resource

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
      flash.now[:notice] = t(:'notice.recovered', resource: t_resource)
      respond_with @address
    end

    def destroy
      if @address.destroy
        @polymorphic_resource.addresses.first.try(:make_primary) if @address.primary?
      end
      flash.now[:notice] = t(:'notice.destroyed', resource: t_resource)
      set_count
      respond_with @address
    end

    def soft_delete
      @primary_address = true if @address.primary?
      @address.soft_delete
      @poymorphic_resource.addresses.first.try(:make_primary) if @address.primary?
      flash.now[:notice] = t(:'notice.destroyed', resource: t_resource)
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

    def t_resource
      t(:'address.singular')
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
