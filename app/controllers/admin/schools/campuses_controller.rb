module Admin
  class Schools::CampusesController < Admin::BaseController

    inherit_resources
    actions :index, :show, :new, :update, :edit, :destroy

    respond_to :js, :html

    before_filter :load_school
    
    def create
      @campus = Campus.new(params[:campus])
      if @campus.save
        @school.campuses << @campus 
        redirect_to admin_school_campuses_path(@school)
      else
        render :new
      end
    end

    private
      def load_school
        @school = School.find(params[:school_id])
      end

  end
end
