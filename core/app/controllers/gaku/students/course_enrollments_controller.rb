module Gaku
  class Students::CourseEnrollmentsController < GakuController

    load_and_authorize_resource :student
    load_and_authorize_resource :course_enrollment, :through => :student, :class => Gaku::CourseEnrollment

    inherit_resources
    belongs_to :student, :parent_class => Gaku::Student
    respond_to :js, :html

    before_filter :load_data

    def create
      create! do |success, failure|
        failure.js { render :error }
      end
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
