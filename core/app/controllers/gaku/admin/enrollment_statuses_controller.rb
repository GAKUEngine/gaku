module Gaku
  class Admin::EnrollmentStatusesController < Admin::BaseController

    load_and_authorize_resource class: EnrollmentStatus

    respond_to :js, :html

    inherit_resources

    before_filter :count, only: %i(create destroy index)

    protected

    def collection
      @enrollment_statuses = EnrollmentStatus.includes(:translations)
    end

    def resource_params
      return [] if request.get?
      [params.require(:enrollment_status).permit(attributes)]
    end

    private

    def count
      @count = EnrollmentStatus.count
    end

    def attributes
      %i(code name is_active immutable)
    end

  end
end
