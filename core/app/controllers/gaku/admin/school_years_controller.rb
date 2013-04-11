module Gaku
  module Admin
    class SchoolYearsController < Admin::BaseController

      load_and_authorize_resource :class => Gaku::SchoolYear

      inherit_resources
      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy, :index]

      private

      def count
        @count = SchoolYear.count
      end


    end
  end
end