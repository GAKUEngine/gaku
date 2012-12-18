module Gaku
  module Admin
    class EnrollmentStatusTypesController < Admin::BaseController

      inherit_resources
      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy, :index]

      private

      def count
        @count = EnrollmentStatusType.count
      end
      
    end
  end
end
