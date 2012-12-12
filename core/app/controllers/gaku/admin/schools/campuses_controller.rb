module Gaku
  module Admin
    class Schools::CampusesController < Admin::BaseController

      inherit_resources
      belongs_to :school, :parent_class => Gaku::School
      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy]

      private

      def count
        @school = School.find(params[:school_id])
        @count = @school.campuses.count
      end

    end
  end
end
