module Gaku
  class Admin::SchoolYears::SemestersController < Admin::BaseController

    authorize_resource class: false

    respond_to :js, :html

    inherit_resources
    belongs_to :school_year, parent_class: SchoolYear

    before_filter :count, only: %i(create destroy index)

    protected

    def resource_params
      return [] if request.get?
      [params.require(:semester).permit(attributes)]
    end

    private

    def count
      @count = Semester.count
    end

    def attributes
      %i(starting ending)
    end

  end
end
