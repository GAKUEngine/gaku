module Gaku
  module Admin
    class RolesController < Admin::BaseController

      load_and_authorize_resource :class =>  Gaku::Role

      inherit_resources
      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy, :index]

      private

      def count
        @count = Role.count
      end

    end
  end
end
