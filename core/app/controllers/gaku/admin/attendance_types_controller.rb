module Gaku
  module Admin
    class AttendanceTypesController < Admin::BaseController

    	inherit_resources

    	respond_to :js, :html, :json

      def index
        super do |format|
          format.json { render :json => @attendance_types.to_json(:root => false)}  
        end
      end
    end
  end
end

