module Gaku
  module Admin
    class GradingMethodsController < Admin::BaseController

      load_and_authorize_resource class: Gaku::GradingMethod

      inherit_resources
      respond_to :js, :html
      before_filter :count, only: [:index, :create, :destroy]

      protected

      def resource_params
        return [] if request.get?
        [params.require(:grading_method).permit(grading_method_attr)]
      end

      private

      def count
        @count = GradingMethod.count
      end

      def grading_method_attr
        %i(description method name curved arguments)
      end

    end
  end
end
