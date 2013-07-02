module Gaku
  module Admin
    class SchoolYears::SemestersController < Admin::BaseController

      authorize_resource class: false

      inherit_resources
      belongs_to :school_year, parent_class: Gaku::SchoolYear


      respond_to :js, :html
      before_filter :count, only: [:create, :destroy, :index]

      protected

      def resource_params
        return [] if request.get?
        [params.require(:semester).permit(semester_attr)]
      end

      private

      def count
        @count = Semester.count
      end

      def semester_attr
        %i(starting ending)
      end

    end
  end
end
