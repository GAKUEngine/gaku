module Gaku
  module Admin
    class AttendanceTypesController < Admin::BaseController

    	inherit_resources
      respond_to :js, :html, :json
      before_filter :count, :only => [:create, :destroy, :index]

      def index
        super do |format|
          format.json { render :json => @attendance_types.to_json(:root => false) }
        end
      end

      private

      def count
        @count = AttendanceType.count
      end
    end
  end
end

