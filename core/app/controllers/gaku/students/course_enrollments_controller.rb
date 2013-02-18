module Gaku
  class Students::CourseEnrollmentsController < GakuController

    load_and_authorize_resource :student
    load_and_authorize_resource :course_enrollment, :through => :student, :class => Gaku::CourseEnrollment

    inherit_resources
    belongs_to :student, :parent_class => Gaku::Student
    respond_to :js, :html

    before_filter :count, :only => [:create, :destroy]

    def create
      create! do |success, failure|
        failure.js { render :error }
      end
    end

    private

    def student
      @student = Student.find(params[:student_id])
    end

    def count
      student
      @count = @student.courses.count
    end
  end
end
