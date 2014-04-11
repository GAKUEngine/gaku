module Gaku
  class Admin::Campuses::AddressesController < Admin::BaseController

    respond_to :js,   only: %i( new create destroy edit update )

    before_action :set_address,  only: %i( edit update destroy )
    before_action :set_campus
    before_action :set_countries, only: %i( new edit )

    def destroy
      @campus.address.destroy
      respond_with @campus.address
    end

    def new
      @address = Address.new
      respond_with @address
    end

    def create
      @address = @campus.build_address(address_params)
      @address.save
      respond_with @address
    end

    def edit
      respond_with @address
    end

    def update
      @address.update(address_params)
      respond_with @address
    end

    private

    def address_params
      params.require(:address).permit(attributes)
    end

    def attributes
      %i( title address1 address2 city zipcode state state_id country country_id deleted primary past )
    end

    def set_campus
      @campus = Campus.find(params[:campus_id])
    end

    def set_address
      @address = Address.find(params[:id])
    end

    def set_countries
      @countries = Country.all
    end

  end
end

