module Gaku
  module Admin
    class GradingMethodSetsController < Admin::BaseController

      load_and_authorize_resource :class =>  Gaku::GradingMethodSet

      inherit_resources
      respond_to :js, :html
      before_filter :count, :only => [:index, :create, :destroy]

      def destroy
        super do |format|
        if @grading_method_set.is_primary?
          GradingMethodSet.first.try(:make_primary)
        end
        format.js { render }
        end
      end

      def make_primary
        @grading_method_set.make_primary
        respond_with @grading_method_set
      end

      private

      def count
        @count = GradingMethodSet.count
      end
    end
  end
end