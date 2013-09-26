module Gaku
  class Admin::Schools::CampusesController < Admin::BaseController

    authorize_resource class: false

    respond_to :js, :html

    inherit_resources
    belongs_to :school, parent_class: School

    before_filter :count, only: %i(create destroy)

    def update
      @campus = Campus.find(params[:id])
      super do |format|
        if params[:campus][:picture]
          format.html do
            redirect_to [:admin, @campus.school, @campus],
                        notice: t(:'notice.uploaded', resource: t(:'picture'))
          end
        else
          format.js { render }
        end
      end
    end

    protected

    def resource_params
      return [] if request.get?
      [params.require(:campus).permit(attributes)]
    end

    private

    def count
      school = School.find(params[:school_id])
      @count = school.campuses.count
    end

    def attributes
      %i(name school_id master picture)
    end

  end
end
