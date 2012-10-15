class Students::CourseEnrollmentsController < ApplicationController

  inherit_resources
  actions :new, :create, :update, :edit, :destroy

  respond_to :js, :html

  before_filter :load_student

  def create
    super do |format|
      if @student.course_enrollments << @course_enrollment
        format.js { render 'create' }  
      else
        @errors = @course_enrollment.errors
        format.js { render 'error' }
      end
    end  
  end

  private 
    def load_student
      @student = Student.find(params[:student_id])
    end
end
