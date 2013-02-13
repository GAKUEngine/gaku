module Gaku
  module Admin
    class EnrollmentStatusesController < Admin::BaseController

      load_and_authorize_resource :class =>  Gaku::EnrollmentStatus

      inherit_resources
      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy, :index]

      private

      def count
        @count = EnrollmentStatus.count
      end

    end
  end
end
