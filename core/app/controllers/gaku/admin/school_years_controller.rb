module Gaku
  class Admin::SchoolYearsController < Admin::BaseController

    load_and_authorize_resource class: SchoolYear

    respond_to :js, :html

    inherit_resources

    before_filter :count, only: %i(create destroy index)

    protected

    def resource_params
      return [] if request.get?
      [params.require(:school_year).permit(attributes)]
    end

    private

    def count
      @count = SchoolYear.count
    end

    def attributes
      %i(starting ending)
    end

  end
end
