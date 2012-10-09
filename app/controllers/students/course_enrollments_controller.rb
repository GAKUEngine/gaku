class Students::CourseEnrollmentsController < ApplicationController

  inherit_resources
  actions :create, :update, :edit, :destroy

  before_filter :load_student, :only => [:new, :create, :edit, :update, :destroy]

  def new
    @course_enrollment = CourseEnrollment.new
    render 'new'  
  end

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

  def edit
    super do |format|
      format.js { render 'edit' }  
    end  
  end

  def update
    super do |format|
      format.js { render 'update' }  
    end  
  end

  def destroy
    super do |format|
      format.js { render 'destroy' }
    end
  end 

  private 
    def load_student
      @student = Student.find(params[:student_id])
    end
end
