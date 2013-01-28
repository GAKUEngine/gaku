module Gaku
  module Admin
    class SpecialtiesController < Admin::BaseController
      inherit_resources
      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy, :index]

      private

      def count
        @count = Specialty.count
      end

    end
  end
end