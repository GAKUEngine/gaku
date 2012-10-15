module Admin
  class Schools::CampusesController < Admin::BaseController

    inherit_resources
    actions :index, :show, :new, :update, :edit, :destroy

    respond_to :js, :html

    before_filter :load_school
    
    def create
      super do |format|
        if @campus.save && @school.campuses << @campus 
          format.js { render 'create' }
        end
      end
    end

    private
      def load_school
        @school = School.find(params[:school_id])
      end

  end
end
