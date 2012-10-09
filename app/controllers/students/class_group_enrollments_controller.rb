class Students::ClassGroupEnrollmentsController < ApplicationController

  before_filter :load_student, :only => [:new, :create]

  def new
    @class_group_enrollment = ClassGroupEnrollment.new
    render 'new'
  end

  def create
    @class_group_enrollment = ClassGroupEnrollment.new(params[:class_group_enrollment])
    respond_to do |format|
      if @class_group_enrollment.save && @student.class_group_enrollments << @class_group_enrollment
        @class_group = ClassGroup.find(@class_group_enrollment.class_group_id)        

        format.js { render 'create' }  
      else
        @errors = @course_enrollment.errors
        format.js { render 'error' }
      end
    end  
  end

  def destroy
    super do |format|
      format.js { render :nothing => true }
    end
  end 

  private 
    def load_student
      @student = Student.find(params[:student_id])
    end
end
