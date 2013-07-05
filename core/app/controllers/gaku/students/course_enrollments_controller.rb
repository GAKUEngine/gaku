module Gaku
  class Students::CourseEnrollmentsController < GakuController

    load_and_authorize_resource :student
    load_and_authorize_resource :course_enrollment, :through => :student, :class => Gaku::CourseEnrollment

    inherit_resources
    belongs_to :student, :parent_class => Gaku::Student

    defaults resource_class: CourseEnrollment,
             instance_name: 'course_enrollment'

    respond_to :js, :html

    before_filter :load_data

    def create
      create! do |success, failure|
        failure.js { render :error }
      end
    end

    protected

    def resource_params
      return [] if request.get?
      [params.require(:course_enrollment).permit([:course_id, :student_id])]
    end

    private

    def load_data
      @courses = Course.includes(:syllabus).collect do |c|
        if c.syllabus_name
          ["#{c.syllabus_name}-#{c.code}", c.id]
        else
          ["#{c.code}", c.id]
        end
      end
    end

  end
end
