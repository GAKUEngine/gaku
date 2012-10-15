class ClassGroups::CoursesController < ApplicationController

  inherit_resources
  actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_class_group, :only => [:new, :create, :edit, :update, :destroy]

  def destroy
    @class_group_course_enrollment = ClassGroupCourseEnrollment.find(params[:id])
    @class_group_course_enrollment.destroy
    respond_to do |format|
      format.js { render 'destroy' }
    end
  end

  def create
    @class_group_course_enrollment = ClassGroupCourseEnrollment.new(params[:class_group_course_enrollment])
    if @class_group_course_enrollment.save
    	respond_with(@class_group_course_enrollment) do |format|
    		format.js { render 'create'}
    	end
    else #TODO
      @errors = @class_group_course_enrollment.errors
      respond_with(@class_group_course_enrollment) do |format|
        format.js { render 'error' }
      end
    end
  end

  def new
    @course = Course.new
    @class_group_course_enrollment = ClassGroupCourseEnrollment.new
    render 'new'  
  end

  private 
    def load_class_group
      @class_group = ClassGroup.find(params[:class_group_id])
    end


end