module Gaku
  module Admin
    class GradingMethodsController < Admin::BaseController

      inherit_resources
      respond_to :js, :html
      before_filter :count, :only => [:index, :create, :destroy]

      private

      def count
        @count = GradingMethod.count
      end
    end
  end
end