module Gaku
  module Admin
    class SchoolYearsController < Admin::BaseController

      load_and_authorize_resource class: Gaku::SchoolYear

      inherit_resources
      respond_to :js, :html

      before_filter :count, only: [:create, :destroy, :index]

      protected

      def resource_params
        return [] if request.get?
        [params.require(:school_year).permit(school_year_attr)]
      end

      private

      def count
        @count = SchoolYear.count
      end

      def school_year_attr
        %i(starting ending)
      end

    end
  end
end
