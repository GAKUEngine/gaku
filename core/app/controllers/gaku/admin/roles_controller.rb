module Gaku
  class Admin::RolesController < Admin::BaseController

    load_and_authorize_resource class: Role

    respond_to :js, :html

    inherit_resources

    before_filter :count, only: %i(create destroy index)

    protected

    def resource_params
      return [] if request.get?
      [params.require(:role).permit(attributes)]
    end

    private

    def count
      @count = Role.count
    end

    def attributes
      %i(name class_group_enrollment extracurricular_activity_enrollment)
    end

  end
end
