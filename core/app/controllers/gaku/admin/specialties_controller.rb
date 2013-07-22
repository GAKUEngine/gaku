module Gaku
  class Admin::SpecialtiesController < Admin::BaseController

    load_and_authorize_resource class: Specialty

    respond_to :js, :html

    inherit_resources

    before_filter :count, only: %i(create destroy index)

    protected

    def resource_params
      return [] if request.get?
      [params.require(:specialty).permit(attributes)]
    end

    private

    def count
      @count = Specialty.count
    end

    def attributes
      %i(name description major_only)
    end

  end
end
