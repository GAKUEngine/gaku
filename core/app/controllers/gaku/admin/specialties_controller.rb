module Gaku
  module Admin
    class SpecialtiesController < Admin::BaseController

      load_and_authorize_resource :class =>  Gaku::Specialty

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
