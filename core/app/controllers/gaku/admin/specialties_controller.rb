module Gaku
  module Admin
    class SpecialtiesController < Admin::BaseController

      load_and_authorize_resource class: Gaku::Specialty

      inherit_resources
      respond_to :js, :html

      before_filter :count, only: [:create, :destroy, :index]

      protected

      def resource_params
        return [] if request.get?
        [params.require(:specialty).permit(specialty_attr)]
      end

      private

      def count
        @count = Specialty.count
      end

      def specialty_attr
        %i(name description major_only)
      end

    end
  end
end
