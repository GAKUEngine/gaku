class CourseGroupsController < ApplicationController
  
  helper_method :sort_column, :sort_direction

  inherit_resources
  actions :show, :new, :create, :update, :edit, :destroy

  respond_to :js, :html

  before_filter :course_group_enrollment,  :only => [:show]
  before_filter :course_groups, :only => [:update]

  def index
    @course_groups = CourseGroup.order( sort_column + " " + sort_direction)
  end

  def create
    super do |format|
      course_groups
      flash.now[:notice] = t('course_groups.course_group_created')
      format.js { render 'create' }
    end
  end

  def destroy
    @course_group = CourseGroup.unscoped.find(params[:id])
    @course_group.destroy
    flash.now[:notice] = t('course_groups.course_group_delete')
    respond_to do |format|
      format.js { render 'destroy' }
    end
  end

  def soft_delete
    @course_group = CourseGroup.find(params[:id])
    @course_group.update_attribute('is_deleted', 'true')
    redirect_to course_groups_path, :notice => t('course_groups.course_group_delete')
  end

  def recovery
    @course_group = CourseGroup.unscoped.find(params[:id])
    @course_group.update_attribute('is_deleted', 'false')
    @course_groups = CourseGroup.where(:is_deleted => true)
    flash.now[:notice] = t('course_groups.course_group_recover')
    respond_to do |format|
      format.js { render 'recovery' } 
    end
  end

  private

    def course_group_enrollment
      @course_group_enrollment = CourseGroupEnrollment.first
    end

    def course_groups
      @course_groups = CourseGroup.all
    end

    def sort_column
      ClassGroup.column_names.include?(params[:sort]) ? params[:sort] : 'name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
  
end
