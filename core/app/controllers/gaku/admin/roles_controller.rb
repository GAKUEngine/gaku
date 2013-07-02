module Gaku
  module Admin
    class RolesController < Admin::BaseController

      load_and_authorize_resource class: Gaku::Role

      inherit_resources
      respond_to :js, :html

      before_filter :count, only: [:create, :destroy, :index]

      protected

      def resource_params
        return [] if request.get?
        [params.require(:role).permit(role_attr)]
      end

      private

      def count
        @count = Role.count
      end

      def role_attr
        %i(name class_group_enrollment extracurricular_activity_enrollment)
      end

    end
  end
end
