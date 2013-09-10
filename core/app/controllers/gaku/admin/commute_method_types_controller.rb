module Gaku
  class Admin::CommuteMethodTypesController < Admin::BaseController

    #load_and_authorize_resource class: CommuteMethodType

    respond_to :js,   only: %i( new create edit update destroy )
    respond_to :html, only: :index

    before_action :set_commute_method_type, only: %i( edit update destroy )

    def index
      @commute_method_types = CommuteMethodType.all
      @count = CommuteMethodType.count
      respond_with @commute_method_types
    end

    def new
      @commute_method_type = CommuteMethodType.new
      respond_with @commute_method_type
    end

    def create
      @commute_method_type = CommuteMethodType.new(commute_method_type_params)
      @commute_method_type.save
      @count = CommuteMethodType.count
      respond_with @commute_method_type
    end

    def edit
    end

    def update
      @commute_method_type.update(commute_method_type_params)
      respond_with @commute_method_type
    end

    def destroy
      @commute_method_type.destroy
      @count = CommuteMethodType.count
      respond_with @commute_method_type
    end

    private

    def set_commute_method_type
      @commute_method_type = CommuteMethodType.find(params[:id])
    end

    def commute_method_type_params
      params.require(:commute_method_type).permit(:name)
    end

  end
end
