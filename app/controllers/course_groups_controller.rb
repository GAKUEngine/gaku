class CourseGroupsController < ApplicationController
	
	helper_method :sort_column, :sort_direction

	inherit_resources

	before_filter :load_before_show, :only => [:show]

	def index
    @course_groups = CourseGroup.order( sort_column + " " + sort_direction)
  end

	def create
		super do |format|
			@course_groups = CourseGroup.all
			flash.now[:notice] = t('course_groups.course_group_created')
			format.js { render 'create'}
		end
	end

	def edit
		super do |format|
			format.js { render 'edit' }
		end
	end

	def update
		super do |format|
			@course_groups = CourseGroup.all
			format.js { render 'update'}
		end
	
	end

	def destroy
		@course_group = CourseGroup.unscoped.find(params[:id])
		@course_group.destroy
		respond_to do |format|
    	format.js { render :nothing => true }
  	end
  end

  def soft_delete
   	@course_group = CourseGroup.find(params[:id])
  	@course_group.update_attribute('is_deleted', 'true')
  	redirect_to course_groups_path, :notice => 'Course group deleted. Call administrator for recovery'
  end

  def recovery
  	@course_group = CourseGroup.unscoped.find(params[:id])
  	@course_group.update_attribute('is_deleted', 'false')
  	@course_groups = CourseGroup.where(:is_deleted => true)
  	flash.now[:notice] = 'Course Group Recovered'
  	respond_to do |format|
  		format.js { render 'recovery' } 
  	end
  end

	private

	def load_before_show
		@course_group_enrollment = CourseGroupEnrollment.first
	end

	def sort_column
    ClassGroup.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
  
end
