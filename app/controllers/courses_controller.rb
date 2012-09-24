class CoursesController < ApplicationController
	
  before_filter :load_before_show, :only => :show
  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy


  def show
    super do |format|
      format.json { render :json => @course.as_json(:include => 'students') }
    end
  end

  def destroy
    super do |format|
      format.js { render :nothing => true}
    end

  end

  private
  
	  def load_before_show
		  @new_course_enrollment = CourseEnrollment.new
	  end

end
