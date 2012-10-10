module Admin
  class Schools::CampusesController < Admin::BaseController

    inherit_resources

    actions :index, :show, :new, :create, :update, :edit, :destroy

    before_filter :load_campus, :only => [ :destroy, :update, :show ]
    before_filter :load_school, :only => [ :index, :new, :create, :edit, :update, :show, :destroy ]
    
    def create
      @campus = Campus.new(params[:campus])
      if @campus.save
        @school.campuses << @campus 
        redirect_to admin_school_campuses_path(@school)
      else
        render :new
      end
    end

    def edit
      super do |format|
        format.js { render 'edit' }  
      end  
    end

    def update
      if @campus.update_attributes(params[:campus])
        respond_to do |format|
          format.js
        end  
      end
    end

    def destroy
      if @campus.destroy
        respond_to do |format|
          format.js { render 'destroy' }
        end
      end
    end

    private
      def load_campus
        @campus = Campus.find(params[:id])
      end

      def load_school
        @school = School.find(params[:school_id])
      end

  end
end
