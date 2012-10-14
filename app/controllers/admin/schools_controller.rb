module Admin
  class SchoolsController < Admin::BaseController
   	
    inherit_resources

    actions :index, :show, :new, :create, :update, :edit, :destroy

    before_filter :load_school, :only => [:edit, :update, :destroy]
    before_filter :schools_count, :only => [:create, :destroy]

    def new
      @school = School.new
      render 'new'  
    end

    def create
    	@school = School.new(params[:school])
      if @school.save
      	load_schools
        respond_to do |format|
          format.js
        end  
      end
    end
  
    def edit
      respond_to do |format|
        format.js { render }
      end
    end

    def update
      if @school.update_attributes(params[:school])
        respond_to do |format|
          format.js
        end  
      end
    end

    def destroy
      if @school.destroy
        load_schools
        respond_to do |format|
          format.js { render 'destroy' }
        end
      end
    end

    private
      def load_school
        @school = School.find(params[:id])
      end

      def schools_count
        @schools_count = School.count
      end

  end
end