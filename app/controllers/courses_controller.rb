class CoursesController < ApplicationController
	
  before_filter :load_before_show, :only => :show
  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def destroy
    destroy! :flash => !request.xhr?
  end

  # enroll class group to course
  def enroll_class_group
    if !params[:course][:class_group_id].blank?
      @course = Course.find(params[:id])
      @class_group = ClassGroup.find(params[:course][:class_group_id])
      @course.enroll_class_group(@class_group)
        respond_to do |format|
          format.js {render 'enroll_class_group'}
        end
    else
      render :nothing => true
    end
  end
  
  private
  
	  def load_before_show
		  @new_course_enrollment = CourseEnrollment.new
	  end

end
