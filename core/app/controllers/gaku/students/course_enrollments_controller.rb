module Gaku
  class Students::CourseEnrollmentsController < GakuController

    inherit_resources
    actions :new, :create, :update, :edit, :destroy

    respond_to :js, :html

    before_filter :student
    before_filter :courses, :only => [:new, :edit]

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

    def student
      @student = Student.find(params[:student_id])
    end

    def courses
      @courses = Course.all
    end
  end
end
