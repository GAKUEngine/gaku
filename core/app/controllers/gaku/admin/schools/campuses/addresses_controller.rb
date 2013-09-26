module Gaku
  class Admin::Schools::Campuses::AddressesController < GakuController

    authorize_resource class: false

    respond_to :js, :html

    inherit_resources

    before_filter :load_data
    before_filter :before_index, only: :index

    def create
      @address = @campus.build_address(address_params)
      respond_with @address if @address.save
    end

    def destroy
      @address = Address.find(params[:id])
      @campus.address.destroy
      respond_with @campus.address
    end

    protected

    def resource_params
      return [] if request.get?
      [address_params]
    end

    private

    def attributes
      %i(title address1 address2 city zipcode state state_id country country_id deleted primary past)
    end

    def address_params
      params.require(:address).permit(attributes)
    end

    def before_index
      @address = @campus.address
    end

    def load_data
      @countries = Country.all.sort_by(&:name).map { |s| [s.name, s.id] }
      @school = School.find(params[:school_id])
      @campus = Campus.find(params[:campus_id])
    end

  end
end

