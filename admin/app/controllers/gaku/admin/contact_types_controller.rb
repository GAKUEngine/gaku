module Gaku
  class Admin::ContactTypesController < Admin::BaseController

    #load_and_authorize_resource class: ContactType

    respond_to :js,   only: %i( new create edit update destroy index )

    before_action :set_contact_type, only: %i( edit update destroy )

    def index
      @contact_types = ContactType.all
      set_count
      respond_with @contact_types
    end

    def new
      @contact_type = ContactType.new
      respond_with @contact_type
    end

    def create
      @contact_type = ContactType.new(contact_type_params)
      @contact_type.save
      set_count
      respond_with @contact_type
    end

    def edit
    end

    def update
      @contact_type.update(contact_type_params)
      respond_with @contact_type
    end

    def destroy
      @contact_type.destroy
      set_count
      respond_with @contact_type
    end

    private

    def set_contact_type
      @contact_type = ContactType.find(params[:id])
    end

    def contact_type_params
      params.require(:contact_type).permit(:name)
    end

    def set_count
      @count = ContactType.count
    end

  end
end
