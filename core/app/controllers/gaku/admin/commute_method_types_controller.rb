module Gaku
  module Admin
    class CommuteMethodTypesController < Admin::BaseController

      load_and_authorize_resource class: Gaku::CommuteMethodType

      inherit_resources
      respond_to :js, :html

      before_filter :count, only: [:create, :destroy, :index]

      protected

      def collection
        @commute_method_types = CommuteMethodType.includes(:translations)
      end

      def resource_params
        return [] if request.get?
        [params.require(:commute_method_type).permit(commute_method_type_attr)]
      end

      private

      def count
        @count = CommuteMethodType.count
      end

      def commute_method_type_attr
        %i(name)
      end

    end
  end
end

