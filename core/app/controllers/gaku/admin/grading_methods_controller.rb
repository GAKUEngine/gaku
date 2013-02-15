module Gaku
  module Admin
    class GradingMethodsController < Admin::BaseController

      load_and_authorize_resource :class =>  Gaku::GradingMethod

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