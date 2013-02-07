module Gaku
  module Admin
    class UsersController < Admin::BaseController

      inherit_resources
      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy, :index]

      private

      def count
        @count = User.count
      end

    end
  end
end
