module Admin
  class EnrollmentStatusTypesController < Admin::BaseController
   	
    inherit_resources
    actions :index, :show, :new, :create, :update, :edit, :destroy

    respond_to :js, :html

    before_filter :load_enrollment_status_types_count, :only => [:create, :destroy]

    private
      def load_enrollment_status_types_count
        @enrollment_status_types_count = EnrollmentStatusType.count
      end
  end
end